// Created for EmotionDesign on 10.03.2023
//  FunctionLayerTestStack.swift
//  EmotionDesign
//
//
//    dmgordienko@gmail.com 2023

import Foundation
import CoreData
import SwiftUI
import OSLog
@testable import EmotionDesign

class FunctionLayer: ObservableObject {
    let mainContext: NSManagedObjectContext
    let calendar: Calendar
    let center: UNUserNotificationCenter
    let emotionJsonList: [InitialEmotion]
    let logger: Logger
    
    init(mainContext: NSManagedObjectContext = DataControllerTestStack.shared.mainContext) {
        self.mainContext = mainContext
        
        self.logger = Logger(subsystem: "EmotionDesign", category: "main")
        self.emotionJsonList = Bundle.main.decode([InitialEmotion].self, from: "EmotionInitialList.json")
        self.calendar = Calendar.current
        self.center = UNUserNotificationCenter.current()
    }

    func createAndFillNewDayEntry(element: EmotionDTO, comment: String, date: Date) {
        let dayDetails = DayDetail(context: mainContext)
        dayDetails.id = UUID()
        dayDetails.comment = ""
        dayDetails.date = date
        saveContext()
        
        let emotion = Emotion(context: mainContext)
        emotion.id = element.emotion.id
        emotion.name = element.emotion.name
        emotion.parent = Int32(element.emotion.parent)
        emotion.comment = comment
        emotion.timestamp = date
        emotion.day = dayDetails
        saveContext()
    }

    func toggleNotifications(data: AppNotification ) {
        guard data.wrappedEnabled == false else {
            let content = UNMutableNotificationContent()
            content.title = "Schedule notification"
            content.subtitle = "What is your feelings right now?"
            content.sound = UNNotificationSound.default
            
            var counter: Int = 0
            for ind in 0..<data.weekdays.count {
                if data.weekdays[ind].wrappedChecked == true  {
                    counter += 1
                    editEntryInNotificationCenter(content: content, data: data, counter: counter, dayIndex: ind)
                }
                saveContext()
            }
            if counter == 0 {
                editEntryInNotificationCenter(content: content, data: data, counter: counter, dayIndex: nil)
            }
            return
        }
        deleteNotificationList(notification: data )
    }
    
    func pushEntryToNotificationCenter(content: UNMutableNotificationContent, data: NotificationEntry, notification: AppNotification, counter: Int, dayIndex: Int?) {
        var dateComponents = DateComponents()
        dateComponents.hour = calendar.component(.hour, from: data.time)
        dateComponents.minute = calendar.component(.minute, from:  data.time)
        if counter == 0 {
            dateComponents.day = calendar.component(.day, from: data.time)
        } else {
            dateComponents.weekday = dayIndex!
        }
        logger.debug("Created entry for following day: \(dateComponents)")
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let notificationObject = NotificationList(context: mainContext)
        notificationObject.id = UUID()
        notificationObject.appNotification = notification
        saveContext()
        logger.debug("Created entry for notification: \(notificationObject)")
        logger.debug("List of alert ID: \(notification.wrappedId.uuidString)")
        counter == 0 ? logger.info("Push one entry to Notification Center") : logger.info("Refresh data in Notification Center")
        let request = UNNotificationRequest(identifier: notificationObject.id!.uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func getChartData(days: FetchedResults<DayDetail>) -> ChartController {
        var chartList: ChartController = ChartController()
        emotionJsonList.forEach { emotion in
            let tempTitle = "\(emotion.name.capitalized) chart"
            let emotionChart: EmotionChart = EmotionChart(title: tempTitle, emotion: emotion.name, color: emotion.getColor())
            chartList.charts.append(emotionChart)
        }
        
        days.forEach { day in
            logger.debug("Current date: \(day.getDate())")
            for ind in 0..<chartList.charts.count {
                var tempIndex = 0
                if chartList.charts[ind].points.firstIndex(where: { Calendar.current.isDate(  $0.date , equalTo: day.wrappedDate, toGranularity: .day ) }) == nil  {
                    logger.debug("Creating point for date: \(day.getDate())")
                    chartList.charts[ind].addPoint(day.wrappedDate)
                    logger.debug("Added new point:")
                    logger.debug("day: \(chartList.charts[ind].points.last!.getDate()), value: \(chartList.charts[ind].points.last!.count), emotion: \(chartList.charts[ind].emotion)")
                    tempIndex = chartList.charts[ind].points.firstIndex(where: { Calendar.current.isDate(  $0.date , equalTo: day.wrappedDate, toGranularity: .day ) })!
                } else {
                    tempIndex = chartList.charts[ind].points.firstIndex(where: { Calendar.current.isDate(  $0.date , equalTo: day.wrappedDate, toGranularity: .day ) })!
                    logger.debug("Saved index: \(tempIndex)")
                }
                
                // Check users data unique emotions
                day.uniqueMainEmotion.forEach { element in
                    if chartList.charts[ind].emotion == emotionJsonList[element.key].name {
                        chartList.charts[ind].points[tempIndex].setValue(element.value)
                        logger.info("Changed point:")
                        logger.debug("Date: \(chartList.charts[ind].points[tempIndex].getDate()), value: \(chartList.charts[ind].points[tempIndex].count ), emotion: \(chartList.charts[ind].emotion)")
                    }
                }
            }
        }
        return chartList
    }
    
    func saveContext() {
        do {
            try mainContext.save()
        } catch {
            let nsError = error as NSError
            logger.error("Unresolved error \(nsError), \(nsError.userInfo)")
            fatalError("\(nsError)")
        }
    }
    
    
    func saveData(data: FetchedResults<DayDetail>, element: EmotionDTO, comment: String, date: Date) {
        guard data.first == nil else {
            var dateFound = false
            data.forEach {
                if Calendar.current.isDate( $0.wrappedDate , equalTo: Date(), toGranularity: .day ) {
                    dateFound = true
                    addEmotionEntryToDay(day: $0, element: element, comment: comment, date: date)
                }
            }
            if dateFound == false {
                createAndFillNewDayEntry(element: element, comment: comment, date: date)
            }
            
            return
        }
        createAndFillNewDayEntry(element: element, comment: comment, date: date)
    }
    
    func saveData(toAdd: NotificationEntry, toEdit: AppNotification?) {
        guard toEdit != nil else {
            saveData(data: toAdd)
            return
        }
        editData(data: toEdit!, from: toAdd)
    }
    
    func saveData( data: NotificationEntry) {
        let content = UNMutableNotificationContent()
        content.title = "Schedule notification"
        content.subtitle = "What is your feelings right now?"
        content.sound = UNNotificationSound.default
        
        let alarm = AppNotification(context: mainContext)
        alarm.id = UUID()
        alarm.title = data.title
        alarm.date = data.time
        saveContext()
        
        var counter: Int = 0
        
        data.period.days.forEach { day in
            let weekday = AppWeekday(context: mainContext)
            weekday.checked = day.checked as NSNumber
            weekday.name = day.name
            weekday.id = day.id
            weekday.position = Int16(day.shortName.rawValue)
            weekday.notification = alarm
            saveContext()
            
            if day.checked {
                logger.debug("Day is: \(day.name)")
                counter += 1
                pushEntryToNotificationCenter(content: content, data: data, notification: alarm, counter: counter, dayIndex: day.shortName.id)
            }
        }
        if counter == 0 {
            pushEntryToNotificationCenter(content: content, data: data, notification: alarm, counter: counter, dayIndex: nil)
        }
    }
    
    func addEmotionEntryToDay(day: DayDetail, element: EmotionDTO, comment: String, date: Date) {
        let emotion = Emotion(context: mainContext)
        emotion.id = element.emotion.id
        emotion.name = element.emotion.name
        emotion.parent = Int32(element.emotion.parent)
        emotion.comment = comment
        emotion.timestamp = date
        emotion.day = day
        emotion.day?.id = day.wrappedId
        emotion.day?.comment = day.wrappedComment
        emotion.day?.date = day.wrappedDate
        saveContext()
    }
    
    func editEntryInNotificationCenter( content: UNMutableNotificationContent, data: AppNotification, counter: Int, dayIndex: Int?) {
        var dateComponents = DateComponents()
        dateComponents.hour = calendar.component(.hour, from: data.wrappedDate)
        dateComponents.minute = calendar.component(.minute, from:  data.wrappedDate)
        if counter == 0 {
            dateComponents.day = calendar.component(.day, from: data.wrappedDate)
        } else {
            dateComponents.weekday = dayIndex!
        }
        logger.debug("Created entry for following day: \(dateComponents)")
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let notificationObject = NotificationList(context: mainContext)
        notificationObject.id = UUID()
        notificationObject.appNotification = data
        saveContext()
        logger.debug("Created entry for notification: \(notificationObject)")
        logger.debug("List of alert ID: \(data.wrappedId.uuidString)")
        counter == 0 ? logger.info("Push one entry to Notification Center") : logger.info("Refresh data in Notification Center")
        let request = UNNotificationRequest(identifier: notificationObject.id!.uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func editData(data: AppNotification, from: NotificationEntry) {
        logger.info("Starting to edit")
        deleteNotificationList(notification: data)
        logger.info("NotificationCleared")
        let content = UNMutableNotificationContent()
        content.title = "Schedule notification"
        content.subtitle = "What is your feelings right now?"
        content.sound = UNNotificationSound.default
        
        data.title = from.title
        data.date = from.time
        saveContext()
        
        guard data.wrappedEnabled == false else {
            var counter: Int = 0
            
            for ind in 0..<data.weekdays.count {
                data.weekdays[ind].checked = from.period.days[ind].checked as NSNumber
                
                if from.period.days[ind].checked  {
                    counter += 1
                    logger.debug("Day is: \(data.weekdays[ind].wrappedName)")
                    editEntryInNotificationCenter(content: content, data: data, counter: counter, dayIndex: ind)
                }
            }
            if counter == 0 {
                editEntryInNotificationCenter(content: content, data: data, counter: counter, dayIndex: nil)
            }
            saveContext()
            return
        }
        for ind in 0..<data.weekdays.count {
            data.weekdays[ind].checked = from.period.days[ind].checked as NSNumber
            saveContext()
        }
    }
    
    func delete( day: DayDetail ) {
        mainContext.delete(day)
        saveContext()
        logger.info("Data removed")
    }
    
    func delete(notification: AppNotification ) {
        mainContext.delete(notification)
        saveContext()
        logger.info("Data removed")
    }
    
    func delete(alert: NotificationList ) {
        mainContext.delete(alert)
        saveContext()
        logger.info("Data removed")
    }
    
    func deleteNotificationList( notification: AppNotification ) {
        guard notification.notificationObjects.count == 0 else {
            removeNotificationsFromTheCenter(notification: notification)
            
            notification.notificationObjects.forEach { alert in
                delete(alert: alert)
            }
            logger.info("Data removed")
            return
        }
        logger.info("Nothing to remove")
    }
    
    func removeNotificationsFromTheCenter(notification: AppNotification ) {
        logger.info("Removing notifications...")
        center.removeDeliveredNotifications(withIdentifiers: notification.notificationObjects.map { $0.id!.uuidString })
        logger.info("Done")
    }
    
    func clearData(data: FetchedResults<DayDetail>) {
        data.forEach {
            mainContext.delete($0)
            saveContext()
        }
    }
}