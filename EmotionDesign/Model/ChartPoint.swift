// Created for EmotionDesign on 25.02.2023
//  ChartPoint.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import Foundation

struct ChartPoint: Identifiable, Hashable {
    var id: UUID = UUID()
    var date: Date
    var count: Int = 0
    
    mutating func increment() {
        self.count += 1
    }
    
    mutating func setValue(_ value: Int) {
        self.count = value
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter.string(from: date)
    }
}
