// Created for EmotionDesign on 26.01.2023
//  EmotionContentsView.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import SwiftUI

struct EmotionContentsView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    
    
    private let emotionJsonList: [InitialEmotion] = Bundle.main.decode([InitialEmotion].self, from: "EmotionInitialList.json")
    
    @State private var emotionDTO: EmotionDTO = EmotionDTO(emotion: SubEmotion(), color: .gray)
    @State private var choice: Int = -1
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(emotionJsonList.indices, id: \.self) { index in
                    Text(emotionJsonList[index].name)
                        .font(.caption2)
                        .foregroundColor(.black)
                        .bold()
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Rectangle()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [
                                    emotionJsonList[index].getColor(),
                                    emotionJsonList[index].getAccentColor(),
                                    (index + 1) < emotionJsonList.count ? emotionJsonList[index+1].getColor() :  emotionJsonList[index].getAccentColor()
                                ]),
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            ))
                        .gesture(
                            TapGesture()
                                .onEnded {
                                    choice = index
                                }
                        )
                }
            }
            .mask(RoundedRectangle(cornerRadius: 40))
            .padding()
            Divider()
            VStack {
                if ( choice == -1 ) {
                    RoundedRectangle(cornerRadius: 40.0)
                        .stroke(lineWidth: 4.0)
                        .opacity(0)
                } else {
                    ElementsView(choice: $choice, emotionDTO:  $emotionDTO)
                    if emotionDTO.chosen {
                        NavigationLink(destination: EmotionDetailsView(element: $emotionDTO)
                            .environment(\.managedObjectContext, moc)
                            .environmentObject(dataController)
                        )
                        {
                            ButtonView(element: $emotionDTO )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}


struct EmotionContentsView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionContentsView()
    }
}

