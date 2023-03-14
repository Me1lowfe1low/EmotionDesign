// Created for EmotionDesign on 13.03.2023
//  NotificationProto.swift
//  EmotionDesign
//
//
//    dmgordienko@gmail.com 2023

import Foundation

protocol NotificationProto {
    var id: UUID { get set }
    var title: String?  { get set }
    var date: Date?  { get set }
}
