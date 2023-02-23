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
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
                .frame(height: 120)
                .shadow(radius: 5)
                .overlay (
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                VStack(alignment: .center) {
                    Text(element.emotion.name)
                        .font(.title3)
                        .bold()
                        .foregroundColor(element.color)
                        .shadow(radius: 0.5)
                    Text(element.emotion.description)
                        .font(.caption2)
                        .lineLimit(nil)
                }
                .multilineTextAlignment(.center)
                .padding()
                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(width: 100, height: 100, alignment: .trailing)
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
