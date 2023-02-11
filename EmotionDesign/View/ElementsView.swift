// Created for EmotionDesign on 10.02.2023
//  ElementsView.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import SwiftUI

struct ElementsView: View {
    @Binding var choice: Int
    @Binding var emotionDTO: EmotionDTO
    private let emotionJsonList: [InitialEmotion] = Bundle.main.decode([InitialEmotion].self, from: "EmotionInitialList.json")
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(emotionJsonList[choice].subEmotions, id: \.id) { emotion in
                        ZStack {
                            AnimatedCircle(emotion: emotionJsonList[choice])
                            Text(emotion.name)
                                .font(.caption2)
                                .frame(width: 70, height: 70 ,alignment: .center)
                                .padding()
                                .fixedSize()
                                .background(LinearGradient(colors: [
                                    ColorMap(rawValue: emotionJsonList[choice].color)!.getColor,
                                    ColorMap(rawValue: emotionJsonList[choice].accentColor)!.getColor
                                ],
                                                           startPoint: .topLeading,
                                                           endPoint: .bottomTrailing), in: FireShape.Fire())
                                .gesture(
                                    TapGesture()
                                        .onEnded {
                                            emotionDTO.setEmotion(emotion, color: ColorMap(rawValue: emotionJsonList[choice].color)!.getColor, chosen: true)
                                        }
                                )
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
            }
        }
        .padding(.horizontal)
    }
}

struct ElementsView_Previews: PreviewProvider {
    static var previews: some View {
        ElementsView(choice: .constant(0), emotionDTO: .constant(EmotionDTO(emotion: SubEmotion(), color: .gray)))
    }
}
