// Created for EmotionDesign on 10.02.2023
//  InitialEmotion.swift
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

struct InitialEmotion: Identifiable, Hashable, Codable {
    let id = UUID()
    var name: String
    var description: String
    var color: String
    let accentColor: String
    var icon: String = "EmotionDesignLogo"
    var subEmotions: [SubEmotion]
    

    func getColor() -> Color {
        ColorMap(rawValue: color)!.getColor
    }
    
    func getAccentColor() -> Color {
        ColorMap(rawValue: accentColor)!.getColor
    }
    
    func returnColors() -> [Color] {
        var colorList: [Color] = []
        colorList.append(getColor())
        colorList.append(getAccentColor())
        return colorList
    }
}
