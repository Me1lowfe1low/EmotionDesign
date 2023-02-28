// Created for EmotionDesign on 22.02.2023
//  NotificationList+CoreDataProperties.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import Foundation
import CoreData


extension NotificationList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotificationList> {
        return NSFetchRequest<NotificationList>(entityName: "NotificationList")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var appNotification: AppNotification?

    public var wrappedId: UUID {
        id ?? UUID()
    }
    
}

extension NotificationList : Identifiable {

}
