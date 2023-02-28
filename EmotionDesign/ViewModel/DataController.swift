// Created for EmotionDesign on 09.02.2023
//  DataController.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import CoreData
import Foundation
import SwiftUI
import OSLog

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "EmotionDesign")
    let calendar = Calendar.current
    let center = UNUserNotificationCenter.current()
    let emotionJsonList: [InitialEmotion] = Bundle.main.decode([InitialEmotion].self, from: "EmotionInitialList.json")
    let logger = Logger(subsystem: "EmotionDesign", category: "main")
    
    
    init(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }

    func createAndFillNewDayEntry(_ context: NSManagedObjectContext, element: EmotionDTO, comment: String, date: Date) {
        let dayDetails = DayDetail(context: context)
        dayDetails.id = UUID()
        dayDetails.comment = ""
        dayDetails.date = date
        saveContext(context)
        
        let emotion = Emotion(context: context)
        emotion.id = element.emotion.id
        emotion.name = element.emotion.name
        emotion.parent = Int32(element.emotion.parent)
        emotion.comment = comment
        emotion.timestamp = date
        emotion.day = dayDetails
        saveContext(context)
    }

    func toggleNotifications(_ context: NSManagedObjectContext, data: AppNotification ) {
        guard data.wrappedEnabled == false else {
            let content = UNMutableNotificationContent()
            content.title = "Schedule notification"
            content.subtitle = "What is your feelings right now?"
            content.sound = UNNotificationSound.default
            
            var counter: Int = 0
            for ind in 0..<data.weekdays.count {
                if data.weekdays[ind].wrappedChecked == true  {
                    counter += 1
                    editEntryInNotificationCenter(context, content: content, data: data, counter: counter, dayIndex: ind)
                }
                saveContext(context)
            }
            if counter == 0 {
                editEntryInNotificationCenter(context, content: content, data: data, counter: counter, dayIndex: nil)
            }
            return
        }
        deleteNotificationList(context, notification: data )
    }
    
    func pushEntryToNotificationCenter(_ context: NSManagedObjectContext, content: UNMutableNotificationContent, data: NotificationEntry, notification: AppNotification, counter: Int, dayIndex: Int?) {
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
        let notificationObject = NotificationList(context: context)
        notificationObject.id = UUID()
        notificationObject.appNotification = notification
        saveContext(context)
        logger.debug("Created entry for notification: \(notificationObject)")
        logger.debug("List of alert ID: \(notification.wrappedId.uuidString)")
        counter == 0 ? logger.info("Push one entry to Notification Center") : logger.info("Refresh data in Notification Center")
        let request = UNNotificationRequest(identifier: notificationObject.id!.uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func getChartData(_ context: NSManagedObjectContext, days: FetchedResults<DayDetail>) -> ChartController {
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
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            logger.error("Unresolved error \(nsError), \(nsError.userInfo)")
            fatalError("\(nsError)")
        }
    }
    
    
    func saveData(_ context: NSManagedObjectContext, data: FetchedResults<DayDetail>, element: EmotionDTO, comment: String, date: Date) {
        guard data.first == nil else {
            var dateFound = false
            data.forEach {
                if Calendar.current.isDate( $0.wrappedDate , equalTo: Date(), toGranularity: .day ) {
                    dateFound = true
                    addEmotionEntryToDay(context,day: $0, element: element, comment: comment, date: date)
                }
            }
            if dateFound == false {
                createAndFillNewDayEntry(context, element: element, comment: comment, date: date)
            }
            
            return
        }
        createAndFillNewDayEntry(context, element: element, comment: comment, date: date)
    }
    
    func saveData(_ context: NSManagedObjectContext, toAdd: NotificationEntry, toEdit: AppNotification?) {
        guard toEdit != nil else {
            saveData(context, data: toAdd)
            return
        }
        editData(context, data: toEdit!, from: toAdd)
    }
    
    func saveData(_ context: NSManagedObjectContext, data: NotificationEntry) {
        let content = UNMutableNotificationContent()
        content.title = "Schedule notification"
        content.subtitle = "What is your feelings right now?"
        content.sound = UNNotificationSound.default
        
        let alarm = AppNotification(context: context)
        alarm.id = UUID()
        alarm.title = data.title
        alarm.date = data.time
        saveContext(context)
        
        var counter: Int = 0
        
        data.period.days.forEach { day in
            let weekday = AppWeekday(context: context)
            weekday.checked = day.checked as NSNumber
            weekday.name = day.name
            weekday.id = day.id
            weekday.position = Int16(day.shortName.rawValue)
            weekday.notification = alarm
            saveContext(context)
            
            if day.checked {
                logger.debug("Day is: \(day.name)")
                counter += 1
                pushEntryToNotificationCenter(context, content: content, data: data, notification: alarm, counter: counter, dayIndex: day.shortName.id)
            }
        }
        if counter == 0 {
            pushEntryToNotificationCenter(context, content: content, data: data, notification: alarm, counter: counter, dayIndex: nil)
        }
    }
    
    func addEmotionEntryToDay(_ context: NSManagedObjectContext,day: DayDetail, element: EmotionDTO, comment: String, date: Date) {
        let emotion = Emotion(context: context)
        emotion.id = element.emotion.id
        emotion.name = element.emotion.name
        emotion.parent = Int32(element.emotion.parent)
        emotion.comment = comment
        emotion.timestamp = date
        emotion.day = day
        emotion.day?.id = day.wrappedId
        emotion.day?.comment = day.wrappedComment
        emotion.day?.date = day.wrappedDate
        saveContext(context)
    }
    
    func editEntryInNotificationCenter(_ context: NSManagedObjectContext, content: UNMutableNotificationContent, data: AppNotification, counter: Int, dayIndex: Int?) {
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
        let notificationObject = NotificationList(context: context)
        notificationObject.id = UUID()
        notificationObject.appNotification = data
        saveContext(context)
        logger.debug("Created entry for notification: \(notificationObject)")
        logger.debug("List of alert ID: \(data.wrappedId.uuidString)")
        counter == 0 ? logger.info("Push one entry to Notification Center") : logger.info("Refresh data in Notification Center")
        let request = UNNotificationRequest(identifier: notificationObject.id!.uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func editData(_ context: NSManagedObjectContext, data: AppNotification, from: NotificationEntry) {
        logger.info("Starting to edit")
        deleteNotificationList(context, notification: data)
        logger.info("NotificationCleared")
        let content = UNMutableNotificationContent()
        content.title = "Schedule notification"
        content.subtitle = "What is your feelings right now?"
        content.sound = UNNotificationSound.default
        
        data.title = from.title
        data.date = from.time
        saveContext(context)
        
        guard data.wrappedEnabled == false else {
            var counter: Int = 0
            
            for ind in 0..<data.weekdays.count {
                data.weekdays[ind].checked = from.period.days[ind].checked as NSNumber
                
                if from.period.days[ind].checked  {
                    counter += 1
                    logger.debug("Day is: \(data.weekdays[ind].wrappedName)")
                    editEntryInNotificationCenter(context, content: content, data: data, counter: counter, dayIndex: ind)
                }
            }
            if counter == 0 {
                editEntryInNotificationCenter(context, content: content, data: data, counter: counter, dayIndex: nil)
            }
            saveContext(context)
            return
        }
        for ind in 0..<data.weekdays.count {
            data.weekdays[ind].checked = from.period.days[ind].checked as NSNumber
            saveContext(context)
        }
    }
    
    func delete(_ context: NSManagedObjectContext, day: DayDetail ) {
        context.delete(day)
        saveContext(context)
        logger.info("Data removed")
    }
    
    func delete(_ context: NSManagedObjectContext, notification: AppNotification ) {
        context.delete(notification)
        saveContext(context)
        logger.info("Data removed")
    }
    
    func delete(_ context: NSManagedObjectContext, alert: NotificationList ) {
        context.delete(alert)
        saveContext(context)
        logger.info("Data removed")
    }
    
    func deleteNotificationList(_ context: NSManagedObjectContext, notification: AppNotification ) {
        guard notification.notificationObjects.count == 0 else {
            removeNotificationsFromTheCenter(context, notification: notification)
            
            notification.notificationObjects.forEach { alert in
                delete(context, alert: alert)
            }
            logger.info("Data removed")
            return
        }
        logger.info("Nothing to remove")
    }
    
    func removeNotificationsFromTheCenter(_ context: NSManagedObjectContext, notification: AppNotification ) {
        logger.info("Removing notifications...")
        center.removeDeliveredNotifications(withIdentifiers: notification.notificationObjects.map { $0.id!.uuidString })
        logger.info("Done")
    }
    
    func clearData(_ context: NSManagedObjectContext, data: FetchedResults<DayDetail>) {
        data.forEach {
            context.delete($0)
            saveContext(context)
        }
    }
    
    
    
#if DEBUG
    static var preview: DataController {
        let storage = DataController(inMemory: true)
        
        let emotionDTO0 = EmotionDTO(emotion: SubEmotion.emotionSample0, color: .green)
        let emotionDTO1 = EmotionDTO(emotion: SubEmotion.emotionSample1, color: .green)
        let emotionDTO2 = EmotionDTO(emotion: SubEmotion.emotionSample2, color: .green)
        let emotionDTO3 = EmotionDTO(emotion: SubEmotion.emotionSample3, color: .green)
        let emotionDTO4 = EmotionDTO(emotion: SubEmotion.emotionSample4, color: .green)
        let emotionDTO5 = EmotionDTO(emotion: SubEmotion.emotionSample5, color: .green)
        let notificationSample = NotificationEntry()
        let tempDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let tempDate1 = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        storage.createAndFillNewDayEntry(storage.container.viewContext, element: emotionDTO0, comment: "", date: tempDate)
        storage.createAndFillNewDayEntry(storage.container.viewContext, element: emotionDTO1, comment: "I've found my car broken", date: tempDate)
        storage.createAndFillNewDayEntry(storage.container.viewContext, element: emotionDTO2, comment: "They said that I've passed the exams", date: tempDate)
        storage.createAndFillNewDayEntry(storage.container.viewContext, element: emotionDTO2, comment: "Hmm", date: tempDate)
        storage.createAndFillNewDayEntry(storage.container.viewContext, element: emotionDTO3, comment: "Strange feeling", date: Date())
        storage.createAndFillNewDayEntry(storage.container.viewContext, element: emotionDTO4, comment: "I've broken my favourite cup", date: Date())
        storage.createAndFillNewDayEntry(storage.container.viewContext, element: emotionDTO5, comment: "I've been invited to the party", date: Date())
        storage.createAndFillNewDayEntry(storage.container.viewContext, element: emotionDTO2, comment: "Saad", date: tempDate1)
        storage.saveData(storage.container.viewContext, toAdd: notificationSample, toEdit: nil)
        
        return storage
    }
#endif
}


