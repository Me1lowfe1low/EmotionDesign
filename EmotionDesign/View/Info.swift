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
    private let emotionList: [InitialEmotion] = Bundle.main.decode([InitialEmotion].self, from: "EmotionInitialList.json")
    
    var body: some View {
        Form {
            Section("Main info") {
                ForEach(emotionList, id: \.self) { mainEmotion in
                    Section(header: Text(mainEmotion.name)
                        .font(.title3)
                        .bold()
                    ) {
                        HStack(alignment: .center) {
                            Text(mainEmotion.description)
                                .font(.callout)
                            Spacer()
                            RoundedRectangle(cornerRadius: 20)
                                .fill(LinearGradient(gradient: Gradient(colors:
                                    mainEmotion.returnColors()),
                                                     startPoint: .topLeading,
                                                     endPoint: .bottomTrailing)
                                     )
                                .frame(width: 150, alignment: .trailing)
                                .scaledToFill()
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
