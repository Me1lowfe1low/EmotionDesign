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
    @EnvironmentObject var userData : UserDetails
    private let emotionList: [GeneralEmotion] = GeneralEmotion.emotionSampleList
    @State private var emotionDTO: EmotionDTO = EmotionDTO(emotion: Emotion(), colour: .gray)
    @State private var choice: Int = -1
    
    var body: some View {
        VStack {
            //Toolbar with elements
            HStack(spacing: 0) {
                Group{
                    ForEach(emotionList.indices, id: \.self) { index in
                        Text(emotionList[index].name!)
                            .font(.caption2)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(Rectangle()
                                .fill(LinearGradient(gradient: Gradient(colors: [
                                    emotionList[index].color.getColor,
                                    emotionList[index].accentColor.getColor,
                                    (index + 1) < emotionList.count ? emotionList[index+1].color.getColor : emotionList[index].accentColor.getColor]),
                                                     startPoint: .leading,
                                                     endPoint: .trailing)
                                     ))
                            .gesture(
                                TapGesture()
                                    .onEnded {
                                        choice = index
                                        print("You've just tapped # \(choice) button")
                                    }
                            )
                    }
                }
            }
            .mask(RoundedRectangle(cornerRadius: 40))
            .padding()
            
            Text("There should be line with buttons")
            //View that will hold all choosen emotions. Each would have it's shape
            Divider()
            VStack {
                if ( choice == -1 ) {
                    RoundedRectangle(cornerRadius: 40.0)
                        .stroke(lineWidth: 4.0)
                        .opacity(0)
                } else {
                    ZStack {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                                ForEach(emotionList[choice].subEmotions.indices) { emotionId in
                                    ZStack {
                                        AnimatedCircle(emotion: emotionList[choice])
                                        Text(emotionList[choice].subEmotions[emotionId].name!)
                                            .font(.caption2)
                                            .frame(width: 70, height: 70 ,alignment: .center)
                                            .padding()
                                            .fixedSize()
                                            .background(LinearGradient(colors: [
                                                emotionList[choice].color.getColor,
                                                emotionList[choice].accentColor.getColor
                                            ],
                                                                       startPoint: .topLeading,
                                                                       endPoint: .bottomTrailing), in: FireShape.Fire())
                                            .gesture(
                                                TapGesture()
                                                    .onEnded {
                                                        emotionDTO.setEmotion(emotionList[choice].subEmotions[emotionId], colour: emotionList[choice].color.getColor, chosen: true)
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
                    //Button
                    if emotionDTO.chosen {
                        NavigationLink(destination: EmotionDetailsView(element: $emotionDTO)
                            .environmentObject(userData))
                        {
                            ButtonView(element: $emotionDTO )
                        }
                    }
                }
            }
        }
    }
}
    


struct EmotionContentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmotionContentsView()
        }
    }
}
