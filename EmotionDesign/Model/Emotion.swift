//
//  Emotion.swift
//  EmotionDesign
//
//  Created by Дмитрий Гордиенко on 25.01.2023.
//

import Foundation

struct Emotion: Emotions {
    var id = UUID()
    var name: String
    
    #if Debug
    static var emotions: [Emotion] = [
        Emotion(name: "emotion#1"),
        Emotion(name: "emotion#2"),
        Emotion(name: "emotion#3"),
        Emotion(name: "emotion#4"),
        Emotion(name: "emotion#5")
    ]
    #endif
}



