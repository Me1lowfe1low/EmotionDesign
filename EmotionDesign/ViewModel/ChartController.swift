// Created for EmotionDesign on 23.02.2023
//  ChartController.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import Foundation
//import SwiftUI

class ChartController: ObservableObject {
    @Published var id: UUID = UUID()
    @Published var charts: [EmotionChart] = []
}
