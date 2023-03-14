// Created for EmotionDesign on 13.03.2023
//  DataControllerMock.swift
//  EmotionDesignTests
//
//
//    dmgordienko@gmail.com 2023

import XCTest
import CoreData
@testable import EmotionDesign

class DataControllerMock: DataControllerProto {
    private(set) var saveContextWasCalled: UInt = 0
    var mainContextStub: NSManagedObjectContext!
    var mainContext: NSManagedObjectContext {
        mainContextStub
    }
    
    func saveContext() {
        saveContextWasCalled += 1
    }
    
    func saveDay(comment: String, date: Date) -> EmotionDesign.DayDetail {
        let dayDetails = DayDetail(context: mainContext)
        saveContextWasCalled += 1
        return dayDetails
    }
    
    func saveEmotion(element: EmotionDesign.EmotionDTO, comment: String, date: Date, dayDetails: EmotionDesign.DayDetail) {
        saveContextWasCalled += 1
    }
    
    func saveNotification(data: EmotionDesign.NotificationEntry) -> EmotionDesign.AppNotification {
        let alarm = AppNotification(context: mainContext)
        saveContextWasCalled += 1
        return alarm
    }
    
    func saveWeekday(day: EmotionDesign.Day, alarm: EmotionDesign.AppNotification) {
        saveContextWasCalled += 1
    }
    
    func editDayData(data: EmotionDesign.AppNotification, from: EmotionDesign.NotificationEntry) {
        saveContextWasCalled += 1
    }
    
    func saveNotificationList(data: EmotionDesign.AppNotification) -> EmotionDesign.NotificationList {
        let alarm = NotificationList(context: mainContext)
        saveContextWasCalled += 1
        return alarm
    }
    
}


