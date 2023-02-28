// Created for EmotionDesign on 25.01.2023
//  ColorMap.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//


import SwiftUI

enum ColorMap: String, CaseIterable, Identifiable {
    case gray
    case green
    case brightgreen
    case chartreuse
    case blue
    case orangered
    case silver
    case forestgreen
    case lightyellow4 = "lightyellow4"
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var id: String {
        return self.rawValue
    }
    
    var getColor: Color {
        Color(rawValue)
    }
}
