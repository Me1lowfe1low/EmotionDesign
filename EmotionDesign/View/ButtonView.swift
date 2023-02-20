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
        ZStack {
            Capsule()
                .stroke(element.color, lineWidth: 4)
                .frame(height: 150)
            Capsule()
                .opacity(0.8)
                .frame(height: 150)
                .scaledToFill()
                .blendMode(.destinationOver)
                .overlay(
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                VStack(alignment: .center) {
                    Text(element.emotion.name)
                        .font(.title3)
                        .bold()
                        .foregroundColor(element.color)
                        .shadow(radius: 0.5)
                    Text(element.emotion.description)
                        .font(.callout)
                        .lineLimit(nil)
                }
                .multilineTextAlignment(.center)
                .padding()
                Spacer()
                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(width: 150, height: 150, alignment: .trailing)
                    .foregroundColor(element.color)
            })
        }
        .padding()
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(element: .constant(EmotionDTO(emotion: SubEmotion.emotionSample , color: .yellow )))
    }
}
