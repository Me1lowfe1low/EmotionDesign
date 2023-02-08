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
    var emotion: Emotion
    var colour: Color
    var chosen: Bool = false
    
    mutating func setEmotion(_ emotion: Emotion, colour: Color, chosen: Bool) {
        self.emotion = emotion
        self.colour = colour
        self.chosen = chosen
    }
}

