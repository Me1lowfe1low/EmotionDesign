// Created for EmotionDesign on 25.01.2023
//  EmotionView.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import SwiftUI

struct EmotionView: View {
    @State var emotion: GeneralEmotion = GeneralEmotion.emotionSampleList[1]
    
    var body: some View {
        VStack {
            Text(emotion.name!)
                .padding()
                .background(emotion.color.getColor)
                .clipShape(Capsule())
        }
    }
}

struct EmotionView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionView()
    }
}
