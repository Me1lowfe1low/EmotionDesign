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
    //private let emotionJsonList: [InitialEmotion] = Bundle.main.decode([InitialEmotion].self, from: "EmotionInitialList.json")
    
    @State private var emotionDTO: EmotionDTO = EmotionDTO(emotion: SubEmotion(), color: .gray)
    @State private var choice: Int = -1
    
    var body: some View {
        VStack {
            Text("How are you feeling?")
                .font(.title)
                .bold()
            Text("At this window you could find several emotions grouped by the one general emotion")
                .font(.caption)
            Divider()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(dataController.emotionJsonList.indices, id: \.self) { index in
                        Button(action: {choice = index
                            emotionDTO.chosen = false } )
                        {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(LinearGradient(gradient: Gradient(colors: [
                                    choice == index ?  dataController.emotionJsonList[index].getColor() : .white,
                                    choice == index ? dataController.emotionJsonList[index].getAccentColor() : .white
                                ]),
                                               startPoint: .leading,
                                               endPoint: .trailing))
                                .frame(width: 100, height: 100 ,alignment: .center)
                                .shadow(radius: 5)
                                .padding()
                                .overlay(
                                    Text(dataController.emotionJsonList[index].name)
                                        .font(.caption2)
                                        .bold()
                                        .fixedSize()
                                        .scaledToFit()
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            Divider()
            VStack {
                if ( choice == -1 ) {
                    RoundedRectangle(cornerRadius: 40.0)
                        .stroke(lineWidth: 4.0)
                        .opacity(0)
                } else {
                    ElementsView(choice: $choice, emotionDTO:  $emotionDTO)
                        .environment(\.managedObjectContext, moc)
                        .environmentObject(dataController)
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
        .padding()
        .navigationTitle("Emotion menu")
        .navigationBarTitleDisplayMode(.inline)
    }
}




struct EmotionContentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmotionContentsView()
                .environment(\.managedObjectContext, DataController.preview.container.viewContext)
                .environmentObject(DataController.preview)
        }
    }
}

