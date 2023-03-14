// Created for EmotionDesign on 28.02.2023
//  ChartFilter.swift
//  EmotionDesign
//
//
//    dmgordienko@gmail.com 2023

import Foundation

struct ChartFilter {
    var startDate: Date
    var endDate: Date
    
    init() {
        self.startDate = Date(timeIntervalSince1970: 0)
        self.endDate = Date(timeIntervalSinceNow: 60 * 60 * 24 )
    }
    
    init(_ daysBack: Int) {
        self.startDate = Calendar.current.date(byAdding: .day, value: daysBack*(-1), to: Date())!
        self.endDate = Date(timeIntervalSinceNow: 60 * 60 * 24 )
    }
    
    func contains(_ date: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        print(dateFormatter.string(from: date))
        print(getDate())
        return (startDate...endDate).contains(date)
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter.string(from: self.startDate) + " - " + dateFormatter.string(from: self.endDate)
    }
}
