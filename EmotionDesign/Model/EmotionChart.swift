// Created for EmotionDesign on 25.02.2023
//  EmotionChart.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

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
