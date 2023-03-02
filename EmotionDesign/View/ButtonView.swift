// Created for EmotionDesign on 29.01.2023
//  ButtonView.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import SwiftUI

struct ButtonView: View {
    @Binding var element: EmotionDTO

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(UIColor.secondarySystemBackground))
                .frame(height: 120)
                .shadow(color: Color(UIColor.systemFill) ,radius: 5)
                .overlay (
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                VStack(alignment: .center) {
                    Text(element.emotion.name)
                        .textCase(.uppercase)
                        .font(.title3)
                        .bold()
                        .foregroundColor(element.color)
                        .shadow(color: Color(UIColor.systemFill) ,radius: 5)
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
