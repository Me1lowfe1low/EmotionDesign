// Created for EmotionDesign on 08.02.2023
//  AnimatedCircle.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import SwiftUI

struct AnimatedCircle: View {
    var emotion: InitialEmotion
    private let multiplier: [Int] = [-1,1]
    @State private var rotationAngle = 0.0
    
    var body: some View {
        ForEach(1...3, id: \.self) { _ in
            Circle()
                .offset(x: CGFloat.random(in: -20...20)*CGFloat(multiplier.randomElement() ?? 1), y: CGFloat.random(in: -20...20)*CGFloat(multiplier.randomElement() ?? 1))
                .fill(LinearGradient(colors: [
                    ColorMap(rawValue: emotion.color)!.getColor,
                    ColorMap(rawValue: emotion.accentColor)!.getColor],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .opacity(Double.random(in: 0.1...0.5))
                .rotationEffect(.degrees(rotationAngle))
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(
                        .linear(duration: 6)
                        .speed(0.2)
                        .repeatForever(autoreverses: false)
                    ){
                        rotationAngle = 360.0
                    }
                }
        }
    }
}

struct AnimatedCircle_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedCircle(emotion: InitialEmotion(name: "EmotionSample", description: "Description", color: "yellow", accentColor: "orangered", subEmotions: [SubEmotion.emotionSample]))
    }
}
