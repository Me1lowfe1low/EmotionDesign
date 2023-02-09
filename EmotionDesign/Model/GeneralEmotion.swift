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
    static var emotions0: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 0),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 0),
        Emotion(name: "emotion#3", description: "Emotion description for the emotion#3", parentId: 0),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 0),
        Emotion(name: "emotion#5", description: "Emotion description for the emotion#5", parentId: 0),
        Emotion(name: "emotion#6", description: "Emotion description for the emotion#6", parentId: 0),
        Emotion(name: "emotion#7", description: "Emotion description for the emotion#7", parentId: 0),
        Emotion(name: "emotion#8", description: "Emotion description for the emotion#8", parentId: 0),
        Emotion(name: "emotion#9", description: "Emotion description for the emotion#9", parentId: 0),
        Emotion(name: "emotion#10", description: "Emotion description for the emotion#10", parentId: 0),
        Emotion(name: "emotion#11", description: "Emotion description for the emotion#11", parentId: 0),
        Emotion(name: "emotion#12", description: "Emotion description for the emotion#12", parentId: 0),
        Emotion(name: "emotion#13", description: "Emotion description for the emotion#13", parentId: 0),
        Emotion(name: "emotion#14", description: "Emotion description for the emotion#14", parentId: 0),
        Emotion(name: "emotion#15", description: "Emotion description for the emotion#15", parentId: 0),
        Emotion(name: "emotion#16", description: "Emotion description for the emotion#16", parentId: 0),
        Emotion(name: "emotion#17", description: "Emotion description for the emotion#17", parentId: 0),
        Emotion(name: "emotion#18", description: "Emotion description for the emotion#18", parentId: 0),
        Emotion(name: "emotion#19", description: "Emotion description for the emotion#19", parentId: 0),
        Emotion(name: "emotion#20", description: "Emotion description for the emotion#20", parentId: 0)
    ]
    
    static var emotions1: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 1),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 1),
        Emotion(name: "emotion#3", description: "Emotion description for the emotion#3", parentId: 1),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 1),
        Emotion(name: "emotion#5", description: "Emotion description for the emotion#5", parentId: 1),
        Emotion(name: "emotion#6", description: "Emotion description for the emotion#6", parentId: 1),
        Emotion(name: "emotion#7", description: "Emotion description for the emotion#7", parentId: 1),
        Emotion(name: "emotion#8", description: "Emotion description for the emotion#8", parentId: 1),
        Emotion(name: "emotion#9", description: "Emotion description for the emotion#9", parentId: 1),
        Emotion(name: "emotion#10", description: "Emotion description for the emotion#10", parentId: 1),
        Emotion(name: "emotion#11", description: "Emotion description for the emotion#11", parentId: 1),
        Emotion(name: "emotion#12", description: "Emotion description for the emotion#12", parentId: 1),
        Emotion(name: "emotion#13", description: "Emotion description for the emotion#13", parentId: 1),
        Emotion(name: "emotion#14", description: "Emotion description for the emotion#14", parentId: 1),
        Emotion(name: "emotion#15", description: "Emotion description for the emotion#15", parentId: 1),
        Emotion(name: "emotion#16", description: "Emotion description for the emotion#16", parentId: 1),
        Emotion(name: "emotion#17", description: "Emotion description for the emotion#17", parentId: 1),
        Emotion(name: "emotion#18", description: "Emotion description for the emotion#18", parentId: 1),
        Emotion(name: "emotion#19", description: "Emotion description for the emotion#19", parentId: 1),
        Emotion(name: "emotion#20", description: "Emotion description for the emotion#20", parentId: 1)
    ]
    
    static var emotions2: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 2),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 2),
        Emotion(name: "emotion#3", description: "Emotion description for the emotion#3", parentId: 2),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 2),
        Emotion(name: "emotion#5", description: "Emotion description for the emotion#5", parentId: 2),
        Emotion(name: "emotion#6", description: "Emotion description for the emotion#6", parentId: 2),
        Emotion(name: "emotion#7", description: "Emotion description for the emotion#7", parentId: 2),
        Emotion(name: "emotion#8", description: "Emotion description for the emotion#8", parentId: 2),
        Emotion(name: "emotion#9", description: "Emotion description for the emotion#9", parentId: 2),
        Emotion(name: "emotion#10", description: "Emotion description for the emotion#10", parentId: 2),
        Emotion(name: "emotion#11", description: "Emotion description for the emotion#11", parentId: 2),
        Emotion(name: "emotion#12", description: "Emotion description for the emotion#12", parentId: 2),
        Emotion(name: "emotion#13", description: "Emotion description for the emotion#13", parentId: 2),
        Emotion(name: "emotion#14", description: "Emotion description for the emotion#14", parentId: 2),
        Emotion(name: "emotion#15", description: "Emotion description for the emotion#15", parentId: 2),
        Emotion(name: "emotion#16", description: "Emotion description for the emotion#16", parentId: 2),
        Emotion(name: "emotion#17", description: "Emotion description for the emotion#17", parentId: 2),
        Emotion(name: "emotion#18", description: "Emotion description for the emotion#18", parentId: 2),
        Emotion(name: "emotion#19", description: "Emotion description for the emotion#19", parentId: 2),
        Emotion(name: "emotion#20", description: "Emotion description for the emotion#20", parentId: 2)
    ]
    
    static var emotions3: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 3),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 3),
        Emotion(name: "emotion#3", description: "Emotion description for the emotion#3", parentId: 3),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 3),
        Emotion(name: "emotion#5", description: "Emotion description for the emotion#5", parentId: 3),
        Emotion(name: "emotion#6", description: "Emotion description for the emotion#6", parentId: 3),
        Emotion(name: "emotion#7", description: "Emotion description for the emotion#7", parentId: 3),
        Emotion(name: "emotion#8", description: "Emotion description for the emotion#8", parentId: 3),
        Emotion(name: "emotion#9", description: "Emotion description for the emotion#9", parentId: 3),
        Emotion(name: "emotion#10", description: "Emotion description for the emotion#10", parentId: 3),
        Emotion(name: "emotion#11", description: "Emotion description for the emotion#11", parentId: 3),
        Emotion(name: "emotion#12", description: "Emotion description for the emotion#12", parentId: 3),
        Emotion(name: "emotion#13", description: "Emotion description for the emotion#13", parentId: 3),
        Emotion(name: "emotion#14", description: "Emotion description for the emotion#14", parentId: 3),
        Emotion(name: "emotion#15", description: "Emotion description for the emotion#15", parentId: 3),
        Emotion(name: "emotion#16", description: "Emotion description for the emotion#16", parentId: 3),
        Emotion(name: "emotion#17", description: "Emotion description for the emotion#17", parentId: 3),
        Emotion(name: "emotion#18", description: "Emotion description for the emotion#18", parentId: 3),
        Emotion(name: "emotion#19", description: "Emotion description for the emotion#19", parentId: 3),
        Emotion(name: "emotion#20", description: "Emotion description for the emotion#20", parentId: 3)
        
    ]
    
    static var emotions4: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 4),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 4),
        Emotion(name: "emotion#3", description: "Emotion description for the emotion#3", parentId: 4),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 4),
        Emotion(name: "emotion#5", description: "Emotion description for the emotion#5", parentId: 4),
        Emotion(name: "emotion#6", description: "Emotion description for the emotion#6", parentId: 4),
        Emotion(name: "emotion#7", description: "Emotion description for the emotion#7", parentId: 4),
        Emotion(name: "emotion#8", description: "Emotion description for the emotion#8", parentId: 4),
        Emotion(name: "emotion#9", description: "Emotion description for the emotion#9", parentId: 4),
        Emotion(name: "emotion#10", description: "Emotion description for the emotion#10", parentId: 4),
        Emotion(name: "emotion#11", description: "Emotion description for the emotion#11", parentId: 4),
        Emotion(name: "emotion#12", description: "Emotion description for the emotion#12", parentId: 4),
        Emotion(name: "emotion#13", description: "Emotion description for the emotion#13", parentId: 4),
        Emotion(name: "emotion#14", description: "Emotion description for the emotion#14", parentId: 4),
        Emotion(name: "emotion#15", description: "Emotion description for the emotion#15", parentId: 4),
        Emotion(name: "emotion#16", description: "Emotion description for the emotion#16", parentId: 4),
        Emotion(name: "emotion#17", description: "Emotion description for the emotion#17", parentId: 4),
        Emotion(name: "emotion#18", description: "Emotion description for the emotion#18", parentId: 4),
        Emotion(name: "emotion#19", description: "Emotion description for the emotion#19", parentId: 4),
        Emotion(name: "emotion#20", description: "Emotion description for the emotion#20", parentId: 4)
    ]
    
    static var emotions5: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 5),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 5),
        Emotion(name: "emotion#3", description: "Emotion description for the emotion#3", parentId: 5),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 5),
        Emotion(name: "emotion#5", description: "Emotion description for the emotion#5", parentId: 5),
        Emotion(name: "emotion#6", description: "Emotion description for the emotion#6", parentId: 5),
        Emotion(name: "emotion#7", description: "Emotion description for the emotion#7", parentId: 5),
        Emotion(name: "emotion#8", description: "Emotion description for the emotion#8", parentId: 5),
        Emotion(name: "emotion#9", description: "Emotion description for the emotion#9", parentId: 5),
        Emotion(name: "emotion#10", description: "Emotion description for the emotion#10", parentId: 5),
        Emotion(name: "emotion#11", description: "Emotion description for the emotion#11", parentId: 5),
        Emotion(name: "emotion#12", description: "Emotion description for the emotion#12", parentId: 5),
        Emotion(name: "emotion#13", description: "Emotion description for the emotion#13", parentId: 5),
        Emotion(name: "emotion#14", description: "Emotion description for the emotion#14", parentId: 5),
        Emotion(name: "emotion#15", description: "Emotion description for the emotion#15", parentId: 5),
        Emotion(name: "emotion#16", description: "Emotion description for the emotion#16", parentId: 5),
        Emotion(name: "emotion#17", description: "Emotion description for the emotion#17", parentId: 5),
        Emotion(name: "emotion#18", description: "Emotion description for the emotion#18", parentId: 5),
        Emotion(name: "emotion#19", description: "Emotion description for the emotion#19", parentId: 5),
        Emotion(name: "emotion#20", description: "Emotion description for the emotion#20", parentId: 5)
    ]
    //static var emotionSample: GeneralEmotion = GeneralEmotion(name: "Happiness", color: ColorMap.forestgreen, accentColor: ColorMap.green, subEmotions: GeneralEmotion.emotions)
    static var emotionSampleList: [GeneralEmotion] = [
        GeneralEmotion(name: "Anger", description: "Description of anger", color: ColorMap.orangered, accentColor: ColorMap.poppy, subEmotions: GeneralEmotion.emotions0),
        GeneralEmotion(name: "Suprise", description: "Description of surprise", color: ColorMap.orange, accentColor: ColorMap.yellow, subEmotions: GeneralEmotion.emotions1),
        GeneralEmotion(name: "Fear", description: "Description of fear", color: ColorMap.yellow, accentColor: ColorMap.lightyellow4, subEmotions: GeneralEmotion.emotions2),
        GeneralEmotion(name: "Happy", description: "Description of happy", color: ColorMap.buttercup, accentColor: ColorMap.green, subEmotions: GeneralEmotion.emotions3),
        GeneralEmotion(name: "Sad", description: "Description of sad", color: ColorMap.lavender, accentColor: ColorMap.sky, subEmotions: GeneralEmotion.emotions4),
        GeneralEmotion(name: "Disgust", description: "Description of disgust", color: ColorMap.periwinkle, accentColor: ColorMap.purple, subEmotions: GeneralEmotion.emotions5)
    ]
#endif
}
