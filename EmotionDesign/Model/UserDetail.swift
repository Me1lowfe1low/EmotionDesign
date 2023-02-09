// Created for EmotionDesign on 07.02.2023
//  UserDetail.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import Foundation

struct UserDetail: Identifiable, Hashable, Comparable {
    static func < (lhs: UserDetail, rhs: UserDetail) -> Bool {
        lhs.date < rhs.date
    }
    
    let id: UUID = UUID()
    var date: Date = Date()
    var emotionList: [Emotion] = [Emotion]()
    var commentList: [String] = [String]()
}
