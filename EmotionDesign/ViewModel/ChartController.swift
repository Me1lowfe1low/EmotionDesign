// Created for EmotionDesign on 23.02.2023
//  ChartController.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import Foundation
//import SwiftUI

class ChartController: ObservableObject {
    @Published var id: UUID = UUID()
    @Published var charts: [EmotionChart] = []
}
