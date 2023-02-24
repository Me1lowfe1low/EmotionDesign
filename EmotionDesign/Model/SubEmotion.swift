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
    var icon: String = "EmotionDesignLogo"
    
#if DEBUG
    static var emotionSample0: SubEmotion = SubEmotion(name: "pride", parent: 2, description: "A feeling of pleasure and satisfaction that you get when you, or someone connected with you, have achieved something special", icon: "pride" )
    static var emotionSample1: SubEmotion = SubEmotion(name: "panicked", parent: 1, description: "To have a sudden strong feeling of fear or worry and be unable to think clearly or calmly or decide what to do", icon: "panicked" )
    static var emotionSample2: SubEmotion = SubEmotion(name: "stressed", parent: 1, description: "Affected by stress", icon: "stressed" )
    static var emotionSample3: SubEmotion = SubEmotion(name: "scared", parent: 1, description: "Frightened, or worried", icon: "scared" )
    static var emotionSample4: SubEmotion = SubEmotion(name: "vengeful", parent: 0, description: "Wanting or trying to harm someone because they have done something bad to you", icon: "pride" )
    static var emotionSample5: SubEmotion = SubEmotion(name: "pleasure", parent: 2, description: "A feeling of happiness, enjoyment, or satisfaction", icon: "pride" )
    static var emotionSample: SubEmotion = SubEmotion(name: "pride", parent: 2, description: "A feeling of pleasure and satisfaction that you get when you, or someone connected with you, have achieved something special", icon: "pride" )
#endif
}


