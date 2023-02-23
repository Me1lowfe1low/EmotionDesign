// Created for EmotionDesign on 22.02.2023
//  NotificationController.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import Foundation

class NotificationController: ObservableObject {
    @Published var notifications = [NotificationEntry]()
    
}
