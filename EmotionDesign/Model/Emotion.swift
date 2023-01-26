//
//  Emotion.swift
//  EmotionDesign
//
//  Created by Дмитрий Гордиенко on 25.01.2023.
//

import Foundation

struct Emotion: Identifiable {
    let id = UUID()
    let name: String
    let color: ColorMap
    let accentColor: ColorMap
    
    
    #if DEBUG
    static var emotionSample: Emotion = Emotion(name: "Happiness", color: ColorMap.forestgreen, accentColor: ColorMap.green)
    static var emotionSampleList: [Emotion] = [
        Emotion(name: "Anger", color: ColorMap.orangered, accentColor: ColorMap.poppy),
        Emotion(name: "Disgust", color: ColorMap.periwinkle, accentColor: ColorMap.purple),
        Emotion(name: "Sad", color: ColorMap.sky, accentColor: ColorMap.blue),
        Emotion(name: "Happy", color: ColorMap.forestgreen, accentColor: ColorMap.green),
        Emotion(name: "Suprise", color: ColorMap.lightyellow4, accentColor: ColorMap.yellow),
        Emotion(name: "Fear", color: ColorMap.tan, accentColor: ColorMap.buttercup)
    ]
    #endif
}



