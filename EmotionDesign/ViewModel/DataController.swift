// Created for EmotionDesign on 09.02.2023
//  DataController.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import CoreData
import Foundation
import OSLog

class DataController: DataControllerProto {
    
    static let shared = DataController()
    
    let container: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext
    private let logger: Logger
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "EmotionDesign")
        self.logger = Logger(subsystem: "EmotionDesign", category: "CoreData")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("Core Data failed to load: \(error!.localizedDescription)")
            }
        }
        mainContext = container.viewContext
        mainContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.parent = self.mainContext
    }
}

extension DataController {
    
    func saveContext() {
        do {
            try mainContext.save()
        } catch {
            let nsError = error as NSError
            logger.error("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func saveDay(comment: String, date: Date) -> DayDetail {
        let dayDetails = DayDetail(context: mainContext)
        dayDetails.id = UUID()
        dayDetails.comment = comment
        dayDetails.date = date
        saveContext()
        logger.debug("Saved day. Comment: \(dayDetails.wrappedComment), Date: \(dayDetails.wrappedDate)")
        return dayDetails
    }
    
    func saveWeekday(day: Day, alarm: AppNotification) {
        let weekday = AppWeekday(context: mainContext)
        weekday.checked = day.checked as NSNumber
        weekday.name = day.name
        weekday.id = day.id
        weekday.position = Int16(day.shortName.rawValue)
        weekday.notification = alarm
        saveContext()
    }
    
    func saveEmotion(element: EmotionDTO, comment: String, date: Date, dayDetails: DayDetail) {
        let emotion = Emotion(context: mainContext)
        emotion.id = element.emotion.id
        emotion.name = element.emotion.name
        emotion.parent = Int32(element.emotion.parent)
        emotion.comment = comment
        emotion.timestamp = date
        emotion.day = dayDetails
        emotion.day?.id = dayDetails.wrappedId
        emotion.day?.comment = dayDetails.wrappedComment
        emotion.day?.date = dayDetails.wrappedDate
        saveContext()
        logger.debug("Saved day. Comment: \(emotion.wrappedComment), Date: \(emotion.wrappedTimestamp)")
    }
    
    func saveNotification(data: NotificationEntry) -> AppNotification {
        let alarm = AppNotification(context: mainContext)
        alarm.id = UUID()
        alarm.title = data.title
        alarm.date = data.date
        saveContext()
        return alarm
    }
    
    func saveNotificationList(data: AppNotification) -> NotificationList {
        let alarm = NotificationList(context: mainContext)
        alarm.id = UUID()
        alarm.appNotification = data
        saveContext()
        return alarm
    }
    
    func editDayData(data: AppNotification, from: NotificationEntry) {
        data.title = from.title
        data.date = from.date
        saveContext()
    }
    
   
}

protocol DataControllerProto: AnyObject {
    var mainContext: NSManagedObjectContext { get }
    
    func saveContext()

    func saveDay(comment: String, date: Date) -> DayDetail
    func saveEmotion(element: EmotionDTO, comment: String, date: Date, dayDetails: DayDetail)
    func saveNotification(data: NotificationEntry) -> AppNotification
    func saveWeekday(day: Day, alarm: AppNotification)
    func editDayData(data: AppNotification, from: NotificationEntry)
    func saveNotificationList(data: AppNotification) -> NotificationList 
}

