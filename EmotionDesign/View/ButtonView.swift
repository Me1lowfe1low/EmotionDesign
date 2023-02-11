// Created for EmotionDesign on 29.01.2023
//  ButtonView.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import SwiftUI

struct ButtonView: View {
    @Binding var element: EmotionDTO

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack {
                Text(element.emotion.name)
                    .font(.title2)
                    .padding(.horizontal)
                    .foregroundColor(element.color)
                Text(element.emotion.description)
                    .padding(.horizontal)
            }
            Image(systemName: "arrow.right.circle.fill")
                .resizable()
                .scaledToFit()
                .padding()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
        }
        .overlay(
        Capsule()
        .fill(.gray)
        .opacity(0.4)
        .blendMode(.destinationOut)
        )
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(element: .constant(EmotionDTO(emotion: SubEmotion.emotionSample , color: .red )))
    }
}
