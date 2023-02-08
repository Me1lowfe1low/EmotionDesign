// Created for EmotionDesign on 08.02.2023
//  Info.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import SwiftUI

struct Info: View {
    private let emotionList: [GeneralEmotion] = GeneralEmotion.emotionSampleList
    
    var body: some View {
        Form {
            Section("Main info") {
                ForEach(emotionList, id: \.self) { generalEmotion in
                    Section(generalEmotion.name!) {
                        HStack(alignment: .center) {
                            Text(generalEmotion.description!)
                            Spacer()
                            RoundedRectangle(cornerRadius: 20)
                                .fill(LinearGradient(gradient: Gradient(colors: [
                                    generalEmotion.color.getColor,
                                    generalEmotion.accentColor.getColor]),
                                                     startPoint: .leading,
                                                     endPoint: .trailing)
                                     )
                                .frame(width: 150, height: 75, alignment: .trailing)
                        }
                    }
                }
            }
        }
    }
}

struct Info_Previews: PreviewProvider {
    static var previews: some View {
        Info()
    }
}
