//
//  Emotions.swift
//  EmotionDesign
//
//  Created by Дмитрий Гордиенко on 27.01.2023.
//

import Foundation

protocol Emotions: Identifiable {
    var id: UUID { get }
    var name: String { get set }
}
