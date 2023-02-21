// Created for EmotionDesign on 21.02.2023
//  AppNotification+CoreDataProperties.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 
//

import Foundation
import CoreData


extension AppNotification {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppNotification> {
        return NSFetchRequest<AppNotification>(entityName: "Notification")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var enabled: Bool
    @NSManaged public var weekday: NSSet?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedTitle: String {
        title ?? ""
    }
    
    public var wrappedDate: Date {
        date ?? Date()
    }
    
   
    public var weekdays: [AppWeekday] {
        let set = weekday as? Set<AppWeekday> ?? []
        
        return set.sorted {
            $0.position < $1.position
        }
    }

    func returnPeriod() -> String {
        var stringPeriod: String = ""
        var nothingChecked = 0
        self.weekdays.forEach { day in
            if day.checked == true {
                stringPeriod += day.wrappedName
                nothingChecked += 1
            }
        }
        if nothingChecked == 7 {
            stringPeriod = "Every day"
        }
        return stringPeriod
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

extension AppNotification : Identifiable {

}
