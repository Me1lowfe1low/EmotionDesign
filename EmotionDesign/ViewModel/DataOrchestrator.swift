// Created for EmotionDesign on 10.03.2023
//  DataOrchestrator.swift
//  EmotionDesign
//
//
//    dmgordienko@gmail.com 2023

import Foundation
import CoreData
import SwiftUI
import OSLog

class DataOrchestrator: ObservableObject {
    let notificationController: NotificationControllerProtocol
    let emotionJsonList: [InitialEmotion]
    let logger: Logger
    let coreDataManipulator: CoreDataManipulatorProtocol
    let chartList: ChartControllerProtocol
    
    init(_ coreDataManipulator: CoreDataManipulatorProtocol = CoreDataManipulator.shared) {
        self.coreDataManipulator = coreDataManipulator
        
        self.logger = Logger(subsystem: "EmotionDesign", category: "main")
        self.emotionJsonList = Bundle.main.decode([InitialEmotion].self, from: "EmotionInitialList.json")
        self.notificationController = NotificationController()
        self.chartList = ChartController()
    }
    
    
    
    func changeNotificationState(notification: AppNotification,to state: Bool) {
        notification.enabled = state as NSNumber
        saveContext()
        toggleNotifications(notification: notification)
    }
    
    func toggleNotifications(notification: AppNotification ) {
        guard notification.wrappedEnabled == false else {
            let content = notificationController.createContent()
            
            var counter: Int = 0
            for ind in 0..<notification.weekdays.count {
                if notification.weekdays[ind].wrappedChecked == true  {
                    counter += 1
                    editEntryInNotificationCenter(content: content, data: notification, counter: counter, dayIndex: ind)
                }
                coreDataManipulator.saveContext()
            }
            if counter == 0 {
                editEntryInNotificationCenter(content: content, data: notification, counter: counter, dayIndex: nil)
            }
            return
        }
        deleteNotificationList(notification: notification )
    }
    
    func addToNotificationCenter(dateComponents: DateComponents, data: AppNotification, counter: Int,content: UNMutableNotificationContent) {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let notificationObject =  coreDataManipulator.saveNotificationList(data: data)
        
        logger.debug("Created entry for notification: \(notificationObject)")
        logger.debug("List of alert ID: \(data.wrappedId.uuidString)")
        counter == 0 ? logger.info("Push one entry to Notification Center") : logger.info("Refresh data in Notification Center")
        
        let request = UNNotificationRequest(identifier: notificationObject.id!.uuidString, content: content, trigger: trigger)
        notificationController.center.add(request)
    }
    
    func pushEntryToNotificationCenter(content: UNMutableNotificationContent, data: NotificationEntry, notification: AppNotification, counter: Int, dayIndex: Int?) {
        var dateComponents = saveTime(data: data, counter: counter, index: dayIndex)
        addToNotificationCenter(dateComponents: dateComponents, data: notification, counter: counter,content: content)
    }
    
    func saveData(data: FetchedResults<DayDetail>, element: EmotionDTO) {
        guard data.first == nil else {
            var dateFound = false
            data.forEach {
                if Calendar.current.isDate( $0.wrappedDate , equalTo: Date(), toGranularity: .day ) {
                    dateFound = true
                    coreDataManipulator.saveEmotion(element: element, dayDetails: $0)
                }
            }
            if dateFound == false {
                createAndFillNewDayEntry(element: element)
            }
            return
        }
        createAndFillNewDayEntry(element: element)
    }
    
    func saveData(toAdd: NotificationEntry, toEdit: AppNotification?) {
        guard toEdit != nil else {
            saveData(data: toAdd)
            return
        }
        editData(data: toEdit!, from: toAdd)
    }
    
    func saveData( data: NotificationEntry) {
        let content = notificationController.createContent()
        let alarm = coreDataManipulator.saveNotification(data: data)
        var counter: Int = 0
        
        data.period.days.forEach { day in
            coreDataManipulator.saveWeekday(day: day, alarm: alarm)
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

    func editEntryInNotificationCenter( content: UNMutableNotificationContent, data: AppNotification, counter: Int, dayIndex: Int?) {
        let dateComponents = saveTime(data: data, counter: counter, index: dayIndex)  // was var
        addToNotificationCenter(dateComponents: dateComponents, data: data, counter: counter,content: content)
    }
    
    func editData(data: AppNotification, from: NotificationEntry) {
        logger.debug("Starting to edit")
        deleteNotificationList(notification: data)
        let content = notificationController.createContent()
        coreDataManipulator.editDayData(data: data, from: from)
        
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
            coreDataManipulator.saveContext()
            return
        }
        for ind in 0..<data.weekdays.count {
            data.weekdays[ind].checked = from.period.days[ind].checked as NSNumber
            coreDataManipulator.saveContext()
        }
    }
    
    func deleteNotificationList( notification: AppNotification ) {
        guard notification.notificationsAreEmpty else {
            removeNotifications(notification: notification)
            
            notification.notificationObjects.forEach { alert in
                delete(alert)
            }
            logger.info("Data removed")
            return
        }
        logger.info("Nothing to remove")
    }
 }

// Notification Center Orchestrator
extension DataOrchestrator {
    
    func removeNotifications(notification: AppNotification ) {
        notificationController.removeNotifications(notification: notification)
    }
    
    func saveTime(data: NotificationEntry, counter: Int, index: Int?) -> DateComponents {
        notificationController.saveTime(data: data, counter: counter, index: index)
    }
    
    func saveTime(data: AppNotification, counter: Int, index: Int?) -> DateComponents {
        notificationController.saveTime(data: data, counter: counter, index: index)
    }
}

// CoreData Orchestrator
extension DataOrchestrator {
    
    func saveContext() {
        coreDataManipulator.saveContext()
    }
    
    func delete(_ object: NSManagedObject) {
        coreDataManipulator.delete(object)
    }
    
    func clearData(data: FetchedResults<DayDetail>) {
        data.forEach {
            coreDataManipulator.delete($0)
        }
    }
    
    func createAndFillNewDayEntry(element: EmotionDTO) {
        let dayDetails = coreDataManipulator.saveDay(comment: "", date: element.date)
        coreDataManipulator.saveEmotion(element: element, dayDetails: dayDetails)
    }
    
}


// Chart Orchestrator
extension DataOrchestrator {
    
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
    
    func getChartData(days: FetchedResults<DayDetail>) -> ChartControllerProtocol {
        chartList.createChartTemplate()
        chartList.fillChartTemplate(days: days)
        return chartList
    }
}
