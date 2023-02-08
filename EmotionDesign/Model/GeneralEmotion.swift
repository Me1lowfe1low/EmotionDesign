// Created for EmotionDesign on 27.01.2023
//  GeneralEmotion.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes


import Foundation

struct GeneralEmotion: Emotions, Hashable {
    var id = UUID()
    var name: String?
    var description: String?
    var color: ColorMap
    let accentColor: ColorMap
    var subEmotions: [Emotion]
    
    #if DEBUG
    static var emotions: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1"),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2"),
        Emotion(name: "emotion#3", description: "Emotion description for the emotion#3"),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4"),
        Emotion(name: "emotion#5", description: "Emotion description for the emotion#5"),
        Emotion(name: "emotion#6", description: "Emotion description for the emotion#6"),
        Emotion(name: "emotion#7", description: "Emotion description for the emotion#7"),
        Emotion(name: "emotion#8", description: "Emotion description for the emotion#8"),
        Emotion(name: "emotion#9", description: "Emotion description for the emotion#9"),
        Emotion(name: "emotion#10", description: "Emotion description for the emotion#10"),
        Emotion(name: "emotion#11", description: "Emotion description for the emotion#11"),
        Emotion(name: "emotion#12", description: "Emotion description for the emotion#12"),
        Emotion(name: "emotion#13", description: "Emotion description for the emotion#13"),
        Emotion(name: "emotion#14", description: "Emotion description for the emotion#14"),
        Emotion(name: "emotion#15", description: "Emotion description for the emotion#15"),
        Emotion(name: "emotion#16", description: "Emotion description for the emotion#16"),
        Emotion(name: "emotion#17", description: "Emotion description for the emotion#17"),
        Emotion(name: "emotion#18", description: "Emotion description for the emotion#18"),
        Emotion(name: "emotion#19", description: "Emotion description for the emotion#19"),
        Emotion(name: "emotion#20", description: "Emotion description for the emotion#20")
    ]
    //static var emotionSample: GeneralEmotion = GeneralEmotion(name: "Happiness", color: ColorMap.forestgreen, accentColor: ColorMap.green, subEmotions: GeneralEmotion.emotions)
    static var emotionSampleList: [GeneralEmotion] = [
        GeneralEmotion(name: "Anger", description: "Description of anger", color: ColorMap.orangered, accentColor: ColorMap.poppy, subEmotions: GeneralEmotion.emotions),
        GeneralEmotion(name: "Suprise", description: "Description of surprise", color: ColorMap.orange, accentColor: ColorMap.yellow, subEmotions: GeneralEmotion.emotions),
        GeneralEmotion(name: "Fear", description: "Description of fear", color: ColorMap.yellow, accentColor: ColorMap.lightyellow4, subEmotions: GeneralEmotion.emotions),
        GeneralEmotion(name: "Happy", description: "Description of happy", color: ColorMap.buttercup, accentColor: ColorMap.green, subEmotions: GeneralEmotion.emotions),
        GeneralEmotion(name: "Sad", description: "Description of sad", color: ColorMap.lavender, accentColor: ColorMap.sky, subEmotions: GeneralEmotion.emotions),
        GeneralEmotion(name: "Disgust", description: "Description of disgust", color: ColorMap.periwinkle, accentColor: ColorMap.purple, subEmotions: GeneralEmotion.emotions)
    ]
    #endif
}
