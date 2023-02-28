// Created for EmotionDesign on 21.02.2023
//  AppWeekday+CoreDataProperties.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import Foundation
import CoreData


extension AppWeekday {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppWeekday> {
        return NSFetchRequest<AppWeekday>(entityName: "Weekday")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var checked: NSNumber?
    @NSManaged public var notification: AppNotification?
    @NSManaged public var position: Int16

    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedName: String {
        name ?? ""
    }
    
    public var wrappedChecked: Bool {
        checked?.boolValue ?? false
    }
}

extension AppWeekday : Identifiable {

}
