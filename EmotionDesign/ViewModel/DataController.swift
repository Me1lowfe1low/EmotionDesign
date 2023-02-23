// Created for EmotionDesign on 09.02.2023
//  DataController.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import CoreData
import Foundation
import SwiftUI

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "EmotionDesign")
    let calendar = Calendar.current
    let center = UNUserNotificationCenter.current()
    
    static var preview: DataController {
        let storage = DataController(inMemory: true)
        
        let emotionDTO = EmotionDTO(emotion: SubEmotion.emotionSample, color: .yellow)
        let notificationSample = NotificationEntry()
        storage.createAndFillNewDayEntry(storage.container.viewContext, element: emotionDTO, comment: "No comments", date: Date())
        storage.saveData(storage.container.viewContext, toAdd: notificationSample, toEdit: nil)
        
        return storage
    }
 
    
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
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
    
    func delete(_ context: NSManagedObjectContext, day: DayDetail ) {
        context.delete(day)
        saveContext(context)
        print("Data removed")
    }
    
    func delete(_ context: NSManagedObjectContext, notification: AppNotification ) {
        context.delete(notification)
        saveContext(context)
        print("Data removed")
    }
    
    func delete(_ context: NSManagedObjectContext, alert: NotificationList ) {
        context.delete(alert)
        saveContext(context)
        print("Data removed")
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
    
    func editData(_ context: NSManagedObjectContext, data: AppNotification, from: NotificationEntry) {
        print("Starting to edit")
        deleteNotificationList(context, notification: data)
        print("NotificationCleared")
        let content = UNMutableNotificationContent()
        content.title = "Schedule notification"
        content.subtitle = "What is your feelings right now?"
        content.sound = UNNotificationSound.default
        
        data.title = from.title
        data.date = from.time
        saveContext(context)
        
        guard data.wrappedEnabled == false else {
            var counter = 0
            
            var dateComponents = DateComponents()
            dateComponents.hour = calendar.component(.hour, from: data.wrappedDate)
            dateComponents.minute = calendar.component(.minute, from:  data.wrappedDate)
            saveContext(context)
            
            for ind in 0..<data.weekdays.count {
                data.weekdays[ind].checked = from.period.days[ind].checked as NSNumber
                
                if from.period.days[ind].checked  {
                    print("Day is: \(data.weekdays[ind].wrappedName)")
                    counter += 1
                    dateComponents.weekday = ind
                    saveContext(context)
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    let notificationObject = NotificationList(context: context)
                    notificationObject.id = UUID()
                    notificationObject.appNotification = data
                    print(notificationObject)
                    saveContext(context)
                    print("List of alert ID: ")
                    print(data)
                    print("Refresh data in Notification Center")
                    let request = UNNotificationRequest(identifier: notificationObject.id!.uuidString, content: content, trigger: trigger)
                    center.add(request)
                }
            }
            if counter == 0 {
                dateComponents.day = calendar.component(.day, from: data.wrappedDate)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let notificationObject = NotificationList(context: context)
                notificationObject.id = UUID()
                notificationObject.appNotification = data
                saveContext(context)
                
                print("Push one entry to Notification Center")
                let request = UNNotificationRequest(identifier: notificationObject.id!.uuidString, content: content, trigger: trigger)
                center.add(request)
            }
            saveContext(context)
            return
        }
        for ind in 0..<data.weekdays.count {
            data.weekdays[ind].checked = from.period.days[ind].checked as NSNumber
            saveContext(context)
        }
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
        
        var dateComponents = DateComponents()
        dateComponents.hour = calendar.component(.hour, from: data.time)
        dateComponents.minute = calendar.component(.minute, from:  data.time)
        
        
        data.period.days.forEach { day in
            let weekday = AppWeekday(context: context)
            weekday.checked = day.checked as NSNumber
            weekday.name = day.name
            weekday.id = day.id
            weekday.position = Int16(day.shortName.rawValue)
            weekday.notification = alarm
            saveContext(context)
            
            
            if day.checked {
                print("Day is: \(day.name)")
                counter += 1
                dateComponents.weekday = day.shortName.id
                print(dateComponents)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let notificationObject = NotificationList(context: context)
                notificationObject.id = UUID()
                notificationObject.appNotification = alarm
                saveContext(context)
                
                print("Push data to Notification Center")
                let request = UNNotificationRequest(identifier: notificationObject.id!.uuidString, content: content, trigger: trigger)
                center.add(request)
            }
        }
        if counter == 0 {
            dateComponents.day = calendar.component(.day, from: data.time)
    
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let notificationObject = NotificationList(context: context)
            notificationObject.id = UUID()
            notificationObject.appNotification = alarm
            saveContext(context)
            
            print("Push one entry to Notification Center")
            let request = UNNotificationRequest(identifier: notificationObject.id!.uuidString, content: content, trigger: trigger)
            center.add(request)
        }
    }
    
    func deleteNotificationList(_ context: NSManagedObjectContext, notification: AppNotification ) {
        guard notification.notificationObjects.count == 0 else {
            removeNotificationsFromTheCenter(context, notification: notification)
            
            notification.notificationObjects.forEach { alert in
                delete(context, alert: alert)
            }
            print("Data removed")
            return
        }
        print("Nothing to remove")
    }
    
    func removeNotificationsFromTheCenter(_ context: NSManagedObjectContext, notification: AppNotification ) {
        print("Removing notifications...")
        center.removeDeliveredNotifications(withIdentifiers: notification.notificationObjects.map { $0.id!.uuidString })
        print("Done")
    }
    
    func toggleNotifications(_ context: NSManagedObjectContext, notification: AppNotification ) {
        guard notification.wrappedEnabled == false else {
            let content = UNMutableNotificationContent()
            content.title = "Schedule notification"
            content.subtitle = "What is your feelings right now?"
            content.sound = UNNotificationSound.default
            
            var count: Int = 0
            
            var dateComponents = DateComponents()
            dateComponents.hour = calendar.component(.hour, from: notification.wrappedDate)
            dateComponents.minute = calendar.component(.minute, from:  notification.wrappedDate)
            saveContext(context)
            
            for ind in 0..<notification.weekdays.count {
                if notification.weekdays[ind].wrappedChecked == true  {
                    dateComponents.weekday = ind
                    saveContext(context)
                    count += 1
                    print(dateComponents)
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    let notificationObject = NotificationList(context: context)
                    notificationObject.id = UUID()
                    notificationObject.appNotification = notification
                    print(notificationObject)
                    saveContext(context)
                    print("List of alert ID: ")
                    print(notification)
                    print("Refresh data in Notification Center")
                    let request = UNNotificationRequest(identifier: notificationObject.id!.uuidString, content: content, trigger: trigger)
                    center.add(request)
                }
                saveContext(context)
            }
            if count == 0 {
                dateComponents.day = calendar.component(.hour, from: notification.wrappedDate)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let notificationObject = NotificationList(context: context)
                notificationObject.id = UUID()
                notificationObject.appNotification = notification
                saveContext(context)
                
                print("Push one entry to Notification Center")
                let request = UNNotificationRequest(identifier: notificationObject.id!.uuidString, content: content, trigger: trigger)
                center.add(request)
            }
            return
        }
        deleteNotificationList(context, notification: notification )
    }
    
    
    
    func clearData(_ context: NSManagedObjectContext, data: FetchedResults<DayDetail>) {
        data.forEach {
            context.delete($0)
            saveContext(context)
        }
    }
}

