// Created for EmotionDesign on 25.02.2023
//  ChartPoint.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import Foundation

struct ChartPoint: ChartPointProtocol {
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

protocol ChartPointProtocol: Identifiable, Hashable, Equatable {
    var id: UUID { get set }
    var date: Date { get set }
    var count: Int { get set }
    
    mutating func increment()
    mutating func setValue(_ value: Int)
    func getDate() -> String
}
