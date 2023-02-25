// Created for EmotionDesign on 29.01.2023
//  EmotionDTO.swift
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

struct EmotionDTO {
    var emotion: SubEmotion
    var color: Color
    var chosen: Bool = false
    
    mutating func setEmotion(_ emotion: SubEmotion, color: Color, chosen: Bool) {
        self.emotion = emotion
        self.color = color
        self.chosen = chosen
    }
    
    func getColor(_ emotion: String, colorSet: [Color] ) -> [Color] {
        if self.emotion.name == emotion {
            return colorSet
        }
        return [ .white, .white]
    }
}

