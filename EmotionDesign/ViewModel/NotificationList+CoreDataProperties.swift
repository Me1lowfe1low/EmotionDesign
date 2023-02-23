// Created for EmotionDesign on 22.02.2023
//  NotificationList+CoreDataProperties.swift
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
