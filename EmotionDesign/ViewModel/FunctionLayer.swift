// Created for EmotionDesign on 10.03.2023
//  FunctionLayer.swift
//  EmotionDesign
//
//
//    dmgordienko@gmail.com 2023

import Foundation
import CoreData
import SwiftUI
import OSLog

class FunctionLayer: ObservableObject {
    let calendar: Calendar
    let center: UNUserNotificationCenter
    let emotionJsonList: [InitialEmotion]
    let logger: Logger
    let dataController: DataControllerProto
    let chartList: ChartController
    
    init(dataController: DataControllerProto = DataController.shared) {
        self.dataController = dataController
        
        self.logger = Logger(subsystem: "EmotionDesign", category: "main")
        self.emotionJsonList = Bundle.main.decode([InitialEmotion].self, from: "EmotionInitialList.json")
        self.calendar = Calendar.current
        self.center = UNUserNotificationCenter.current()
        self.chartList = ChartController()
    }
    
    func getEmotionCharts() -> [EmotionChart] {
        return chartList.getCharts()
    }
    
    func getChartTitle(_ index: Int) -> String {
        return chartList.getChartTitle(index)
    }
    
    func getChartColor(_ currentState: String, index: Int?) -> Color {
        guard currentState == "Chart" || index == nil else {
            return chartList.getChartColor(index!)
        }
        return Color(UIColor.link)
    }
    
    func getChartColor(_ index: Int?) -> Color {
        guard index == nil else {
            return chartList.getChartColor(index!)
        }
        return Color(UIColor.link)
    }
    
    func chartIsEmpty(_ index: Int?) -> Bool {
        guard index == nil else {
            return chartList.chartIsEmpty(index!)
        }
        return false
    }
    
    func getChartPoints(_ index: Int?) -> [ChartPoint] {
        guard index == nil else {
            return chartList.getChartPoints(index!)
        }
        return []
    }
    
    func getChartPeriod(_ tag: String) -> ChartFilter {
        var filter: ChartFilter
        if tag == "Whole history" {
            filter = ChartFilter()
        }  else  {
            filter = ChartFilter(7)
        }
        logger.debug("\(filter.getDate())")
        return filter
    }
    
//    func getChartData(days: FetchedResults<DayDetail>) -> ChartController {
//        chartList.createChartTemplate()
//
//        days.forEach { day in
//            logger.debug("Current date: \(day.getDate())")
//
//            for ind in 0..<chartList.charts.count {
//                var tempIndex = 0
//                if chartList.charts[ind].points.firstIndex(where: { Calendar.current.isDate(  $0.date , equalTo: day.wrappedDate, toGranularity: .day ) }) == nil  {
//
//                    logger.debug("Creating point for date: \(day.getDate())")
//
//                    chartList.charts[ind].addPoint(day.wrappedDate)
//
//
//                    logger.debug("Added new point:")
//                    logger.debug("day: \(self.chartList.charts[ind].points.last!.getDate()), value: \(self.chartList.charts[ind].points.last!.count), emotion: \(self.chartList.charts[ind].emotion)")
//
//                    tempIndex = chartList.charts[ind].points.firstIndex(where: { Calendar.current.isDate(  $0.date , equalTo: day.wrappedDate, toGranularity: .day ) })!
//                } else {
//                    tempIndex = chartList.charts[ind].points.firstIndex(where: { Calendar.current.isDate(  $0.date , equalTo: day.wrappedDate, toGranularity: .day ) })!
//
//                    logger.debug("Saved index: \(tempIndex)")
//                }
//
//                // Check users data unique emotions
//                day.uniqueMainEmotion.forEach { element in
//                    if self.chartList.charts[ind].emotion == emotionJsonList[element.key].name {
//                        chartList.charts[ind].points[tempIndex].setValue(element.value)
//
//                        logger.info("Changed point:")
//                        logger.debug("Date: \(self.chartList.charts[ind].points[tempIndex].getDate()), value: \(self.chartList.charts[ind].points[tempIndex].count ), emotion: \(self.chartList.charts[ind].emotion)")
//                    }
//                }
//            }
//        }
//        return chartList
//    }
    
    func getChartData(days: FetchedResults<DayDetail>) -> ChartController {
        chartList.createChartTemplate()
        chartList.fillChartTemplate(days: days)
        return chartList
    }
    
    
    
    
    
    
    func saveContext() {
        dataController.saveContext()
    }
    
    func createAndFillNewDayEntry(element: EmotionDTO, comment: String, date: Date) {
        let dayDetails = dataController.saveDay(comment: "", date: date)
        dataController.saveEmotion(element: element, comment: comment, date: date, dayDetails: dayDetails)
    }
    
    func createContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Schedule notification"
        content.subtitle = "What is your feelings right now?"
        content.sound = UNNotificationSound.default
        return content
    }
    
    func toggleNotifications(data: AppNotification ) {
        guard data.wrappedEnabled == false else {
            let content = createContent()
            
            var counter: Int = 0
            for ind in 0..<data.weekdays.count {
                if data.weekdays[ind].wrappedChecked == true  {
                    counter += 1
                    editEntryInNotificationCenter(content: content, data: data, counter: counter, dayIndex: ind)
                }
                dataController.saveContext()
            }
            if counter == 0 {
                editEntryInNotificationCenter(content: content, data: data, counter: counter, dayIndex: nil)
            }
            return
        }
        deleteNotificationList(notification: data )
    }
    
    func pushEntryToNotificationCenter(content: UNMutableNotificationContent, data: NotificationEntry, notification: AppNotification, counter: Int, dayIndex: Int?) {
        var dateComponents = saveTime(data: data, counter: counter, index: dayIndex)
        addToNotificationCenter(dateComponents: dateComponents, data: notification, counter: counter,content: content)
    }
    

    
    func saveData(data: FetchedResults<DayDetail>, element: EmotionDTO, comment: String, date: Date) {
        guard data.first == nil else {
            var dateFound = false
            data.forEach {
                if Calendar.current.isDate( $0.wrappedDate , equalTo: Date(), toGranularity: .day ) {
                    dateFound = true
                    dataController.saveEmotion(element: element, comment: comment, date: date, dayDetails: $0)
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
        let content = createContent()
        let alarm = dataController.saveNotification(data: data)
        var counter: Int = 0
        
        data.period.days.forEach { day in
            dataController.saveWeekday(day: day, alarm: alarm)
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
 
    func saveTime(data: NotificationEntry, counter: Int, index: Int?) -> DateComponents {
        var dateComponents = DateComponents()
        dateComponents.hour = calendar.component(.hour, from: data.date)
        dateComponents.minute = calendar.component(.minute, from:  data.date)
        if counter == 0 {
            dateComponents.day = calendar.component(.day, from: data.date)
        } else {
            dateComponents.weekday = index!
        }
        logger.debug("Created entry for following day: \(dateComponents)")
        return dateComponents
    }
    
    func saveTime(data: AppNotification, counter: Int, index: Int?) -> DateComponents {
        var dateComponents = DateComponents()
        dateComponents.hour = calendar.component(.hour, from: data.wrappedDate)
        dateComponents.minute = calendar.component(.minute, from:  data.wrappedDate)
        if counter == 0 {
            dateComponents.day = calendar.component(.day, from: data.wrappedDate)
        } else {
            dateComponents.weekday = index!
        }
        logger.debug("Created entry for following day: \(dateComponents)")
        return dateComponents
    }
    
    func editEntryInNotificationCenter( content: UNMutableNotificationContent, data: AppNotification, counter: Int, dayIndex: Int?) {
        var dateComponents = saveTime(data: data, counter: counter, index: dayIndex)
        addToNotificationCenter(dateComponents: dateComponents, data: data, counter: counter,content: content)
    }
    
    func addToNotificationCenter(dateComponents: DateComponents, data: AppNotification, counter: Int,content: UNMutableNotificationContent) {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let notificationObject =  dataController.saveNotificationList(data: data)
        
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
        let content = createContent()
        dataController.editDayData(data: data, from: from)
        
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
            dataController.saveContext()
            return
        }
        for ind in 0..<data.weekdays.count {
            data.weekdays[ind].checked = from.period.days[ind].checked as NSNumber
            dataController.saveContext()
        }
    }
    
    func delete( day: DayDetail ) {
        dataController.mainContext.delete(day)
        dataController.saveContext()
        logger.info("Data removed")
    }
    
    func delete(notification: AppNotification ) {
        dataController.mainContext.delete(notification)
        dataController.saveContext()
        logger.info("Data removed")
    }
    
    func delete(alert: NotificationList ) {
        dataController.mainContext.delete(alert)
        dataController.saveContext()
        logger.info("Data removed")
    }
    
    func deleteNotificationList( notification: AppNotification ) {
        guard notification.notificationsAreEmpty else {
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
            dataController.mainContext.delete($0)
            dataController.saveContext()
        }
    }
}
