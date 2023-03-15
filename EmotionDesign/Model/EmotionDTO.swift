// Created for EmotionDesign on 29.01.2023
//  EmotionDTO.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import Foundation
import SwiftUI

struct EmotionDTO {
    var emotion: SubEmotion
    var color: Color
    var chosen: Bool = false
    var comment: String = ""
    var date: Date = Date()
    
    
    mutating func changeChosenState(to state: Bool) {
        self.chosen = state
    }
    
    mutating func setEmotion(_ emotion: SubEmotion, color: Color, chosen: Bool) {
        self.emotion = emotion
        self.color = color
        self.chosen = chosen
    }
    
    func getColor(_ emotion: String, colorSet: [Color] ) -> [Color] {
        if self.emotion.name == emotion && self.chosen == true {
            return colorSet
        }
        return [ Color(UIColor.secondarySystemBackground), Color(UIColor.secondarySystemBackground)]
    }
    
    mutating func resetState() {
        self.comment = ""
        self.date = Date()
        self.chosen = false
    }
    
    mutating func applyChanges(comment: String, date: Date) {
        self.comment = comment
        self.date = date
    }
}

