// Created for EmotionDesign on 10.02.2023
//  InitialEmotion.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

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
    
    func findEmotionIcon(_ emotion: String) -> String {
        let tempArray: [String] = subEmotions.filter{ $0.name == emotion }.map { $0.name }
        guard tempArray.isEmpty else {
            return tempArray.first!
        }
        return ""
    }
}
