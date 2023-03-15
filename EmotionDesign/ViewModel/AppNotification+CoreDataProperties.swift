// Created for EmotionDesign on 23.02.2023
//  AppNotification+CoreDataProperties.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import Foundation
import CoreData


extension AppNotification {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppNotification> {
        return NSFetchRequest<AppNotification>(entityName: "AppNotification")
    }
    
    @NSManaged public var date: Date?
    @NSManaged public var enabled: NSNumber?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var weekday: NSSet?
    @NSManaged public var notifications: NSSet?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedTitle: String {
        title ?? ""
    }
    
    public var wrappedDate: Date {
        date ?? Date()
    }
    
    public var wrappedEnabled: Bool {
        enabled?.boolValue ?? true
    }
    
    public var weekdays: [AppWeekday] {
        let set = weekday as? Set<AppWeekday> ?? []
        
        return set.sorted {
            $0.position < $1.position
        }
    }
    
    public var notificationObjects : [NotificationList] {
        let set = notifications as? Set<NotificationList> ?? []
        
        return set.sorted {
            $0.wrappedId.uuidString < $1.wrappedId.uuidString
        }
    }
    
    public var notificationsAreEmpty: Bool {
        notificationObjects.count == 0
    }
}

// MARK: Generated accessors for weekday
extension AppNotification {

    @objc(addWeekdayObject:)
    @NSManaged public func addToWeekday(_ value: AppWeekday)

    @objc(removeWeekdayObject:)
    @NSManaged public func removeFromWeekday(_ value: AppWeekday)

    @objc(addWeekday:)
    @NSManaged public func addToWeekday(_ values: NSSet)

    @objc(removeWeekday:)
    @NSManaged public func removeFromWeekday(_ values: NSSet)

}

// MARK: Generated accessors for notifications
extension AppNotification {

    @objc(addNotificationsObject:)
    @NSManaged public func addToNotifications(_ value: NotificationList)

    @objc(removeNotificationsObject:)
    @NSManaged public func removeFromNotifications(_ value: NotificationList)

    @objc(addNotifications:)
    @NSManaged public func addToNotifications(_ values: NSSet)

    @objc(removeNotifications:)
    @NSManaged public func removeFromNotifications(_ values: NSSet)

}

extension AppNotification : Identifiable {

    func returnPeriod() -> String {
         var stringPeriod: String = ""
         var nothingChecked = 0
         self.weekdays.forEach { day in
             if day.wrappedChecked == true {
                 stringPeriod += "\(day.wrappedName.prefix(3)) "
                 nothingChecked += 1
             }
         }
         if nothingChecked == 7 {
             stringPeriod = "Every day"
         }
         return stringPeriod
     }
     
     func returnWeek() -> Week {
         var weekEntry = Week()
         for ind in 0..<weekdays.count {
             weekEntry.days[ind].id = weekdays[ind].wrappedId
             weekEntry.days[ind].name = weekdays[ind].wrappedName
             weekEntry.days[ind].checked = weekdays[ind].wrappedChecked
         }
         return weekEntry
     }
    
    
}
