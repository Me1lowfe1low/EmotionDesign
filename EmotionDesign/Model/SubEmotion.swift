// Created for EmotionDesign on 11.02.2023
//  SubEmotion.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import Foundation

struct SubEmotion: Identifiable, Hashable, Codable {
    let id = UUID()
    var name: String = ""
    var parent: Int = 0
    var description: String = ""
    
#if DEBUG
static var emotionSample: SubEmotion = SubEmotion(name: "emotion#1", description: "Emotion description for the test puproses. The most common emotion in the world")
#endif
}


