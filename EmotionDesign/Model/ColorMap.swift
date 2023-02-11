// Created for EmotionDesign on 25.01.2023
//  ColorMap.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes


import SwiftUI

enum ColorMap: String, CaseIterable, Identifiable {
    case gray = "gray"
    case green = "green"
    case blue = "blue"
    case orangered = "orangered"
    case silver = "silver"
    case forestgreen = "forestgreen"
    case lightyellow4 = "lightyellow4"
    case bubblegum = "bubblegum"
    case buttercup = "buttercup"
    case indigo = "indigo"
    case lavender = "lavender"
    case magenta = "magenta"
    case navy = "navy"
    case orange = "orange"
    case oxblood = "oxblood"
    case periwinkle = "periwinkle"
    case poppy = "poppy"
    case purple = "purple"
    case seafoam = "seafoam"
    case sky = "sky"
    case tan = "tan"
    case teal = "teal"
    case yellow = "yellow"
    
    var id: String {
        return self.rawValue
    }
    
    var getColor: Color {
        Color(rawValue)
    }
}
