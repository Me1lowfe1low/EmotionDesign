// Created for EmotionDesign on 15.03.2023
//  NotificationController.swift
//  EmotionDesign
//
//
//    dmgordienko@gmail.com 2023

import Foundation
import UserNotifications
import OSLog


class NotificationController: NotificationControllerProtocol {
    var calendar: Calendar
    var center: UNUserNotificationCenter
    var logger: Logger
    
    init() {
        self.calendar = Calendar.current
        self.center = UNUserNotificationCenter.current()
        self.logger = Logger(subsystem: "EmotionDesign", category: "NotificationCenter")
    }
    
    func saveTime(data: AppNotification, counter: Int, index: Int?) -> DateComponents {
        var dateComponents = DateComponents()
        dateComponents.hour = calendar.component(.hour, from: data.wrappedDate)
        dateComponents.minute = calendar.component(.minute, from:  data.wrappedDate)
        if counter == 0 {
            dateComponents.day = calendar.component(.day, from: data.wrappedDate)
        } else {
            guard index != nil else {
                logger.error("saveTime: nil index provided")
                return dateComponents
            }
            dateComponents.weekday = index!
        }
        logger.debug("Created entry for following day: \(dateComponents)")
        return dateComponents
    }
    
    func saveTime(data: NotificationEntry, counter: Int, index: Int?) -> DateComponents {
        var dateComponents = DateComponents()
        dateComponents.hour = calendar.component(.hour, from: data.date)
        dateComponents.minute = calendar.component(.minute, from:  data.date)
        if counter == 0 {
            dateComponents.day = calendar.component(.day, from: data.date)
        } else {
            guard index != nil else {
                logger.error("saveTime: nil index provided")
                return dateComponents
            }
            dateComponents.weekday = index!
        }
        logger.debug("Created entry for following day: \(dateComponents)")
        return dateComponents
    }
    
    func createContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Schedule notification"
        content.subtitle = "What is your feelings right now?"
        content.sound = UNNotificationSound.default
        return content
    }
    
    func removeNotifications(notification: AppNotification) {
        logger.debug("Removing notifications...")
        center.removeDeliveredNotifications(withIdentifiers: notification.notificationObjects.map { $0.id!.uuidString })
        logger.debug("Done")
    }
}

protocol NotificationControllerProtocol {
    var calendar: Calendar { get set }
    var center: UNUserNotificationCenter { get set }
    
    func saveTime(data: AppNotification, counter: Int, index: Int?) -> DateComponents
    func saveTime(data: NotificationEntry, counter: Int, index: Int?) -> DateComponents
    func createContent() -> UNMutableNotificationContent
    func removeNotifications(notification: AppNotification)
}
