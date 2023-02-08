// Created for EmotionDesign on 27.01.2023
//  Emotions.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import Foundation

protocol Emotions: Identifiable {
    var id: UUID { get }
    var name: String? { get }
    var description: String? { get }
}
