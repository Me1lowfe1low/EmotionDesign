// Created for EmotionDesign on 25.02.2023
//  EmotionChart.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import Foundation
import SwiftUI

struct EmotionChart: Identifiable {
    var id: UUID = UUID()
    var title: String
    var emotion: String
    var color: Color
    var points: [ChartPoint] = []
    
    mutating func addPoint(_ date: Date) {
        points.append(ChartPoint(date: date))
    }
}
