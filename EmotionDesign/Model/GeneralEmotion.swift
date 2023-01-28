//
//  GeneralEmotion.swift
//  EmotionDesign
//
//  Created by Дмитрий Гордиенко on 27.01.2023.
//

import Foundation

struct GeneralEmotion: Emotions {
    var id = UUID()
    var name: String
    var color: ColorMap
    let accentColor: ColorMap
    var subEmotions: [Emotion]
    
    #if DEBUG
    static var emotions: [Emotion] = [
        Emotion(name: "emotion#1"),
        Emotion(name: "emotion#2"),
        Emotion(name: "emotion#3"),
        Emotion(name: "emotion#4"),
        Emotion(name: "emotion#5")
    ]
    static var emotionSample: GeneralEmotion = GeneralEmotion(name: "Happiness", color: ColorMap.forestgreen, accentColor: ColorMap.green, subEmotions: GeneralEmotion.emotions)
    static var emotionSampleList: [GeneralEmotion] = [
        GeneralEmotion(name: "Anger", color: ColorMap.orangered, accentColor: ColorMap.poppy, subEmotions: GeneralEmotion.emotions),
        GeneralEmotion(name: "Suprise", color: ColorMap.orange, accentColor: ColorMap.yellow, subEmotions: GeneralEmotion.emotions),
        GeneralEmotion(name: "Fear", color: ColorMap.yellow, accentColor: ColorMap.lightyellow4, subEmotions: GeneralEmotion.emotions),
        GeneralEmotion(name: "Happy", color: ColorMap.buttercup, accentColor: ColorMap.green, subEmotions: GeneralEmotion.emotions),
        GeneralEmotion(name: "Sad", color: ColorMap.lavender, accentColor: ColorMap.sky, subEmotions: GeneralEmotion.emotions),
        GeneralEmotion(name: "Disgust", color: ColorMap.periwinkle, accentColor: ColorMap.purple, subEmotions: GeneralEmotion.emotions)
    ]
    #endif
}
