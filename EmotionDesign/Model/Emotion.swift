// Created for EmotionDesign on 25.01.2023
//  Emotion.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes


import Foundation

struct Emotion: Emotions, Hashable {
    var id = UUID()
    var name: String? = "default name"
    var description: String? = "default description"
    var parentId: Int = 0
    
    #if DEBUG
    static var emotionSample: Emotion = Emotion(name: "emotion#1", description: "Emotion description for the test puproses. The most common emotion in the world")
    #endif
}



