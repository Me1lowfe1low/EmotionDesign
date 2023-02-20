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
                        Button(action: { emotionDTO.setEmotion(emotion, color: emotionJsonList[choice].getColor(), chosen: true)} )
                        {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .frame(width: 90, height: 90 ,alignment: .center)
                                .shadow(radius: 5)
                                .overlay(
                                    Text(emotion.name)
                                        .font(.caption2)
                                        .bold()
                                        .fixedSize()
                                        .scaledToFit()
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding()
                }
            }
        }
    }
}

struct ElementsView_Previews: PreviewProvider {
    static var previews: some View {
        ElementsView(choice: .constant(0), emotionDTO: .constant(EmotionDTO(emotion: SubEmotion(), color: .green)))
    }
}
