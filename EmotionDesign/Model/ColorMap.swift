//
//  ColorMap.swift
//  EmotionDesign
//
//  Created by Дмитрий Гордиенко on 25.01.2023.
//

import SwiftUI

enum ColorMap: String, CaseIterable, Identifiable {
    case gray, green, blue, orangered, silver, forestgreen, lightyellow4, bubblegum, buttercup, indigo, lavender, magenta, navy, orange, oxblood, periwinkle, poppy, purple, seafoam, sky, tan, teal, yellow
    
    var id: String {
        return self.rawValue
    }
    
    var getColor: Color {
        Color(rawValue)
    }
}
