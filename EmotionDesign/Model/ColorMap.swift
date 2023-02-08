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
    case gray, green, blue, orangered, silver, forestgreen, lightyellow4, bubblegum, buttercup, indigo, lavender, magenta, navy, orange, oxblood, periwinkle, poppy, purple, seafoam, sky, tan, teal, yellow
    
    var id: String {
        return self.rawValue
    }
    
    var getColor: Color {
        Color(rawValue)
    }
}
