// Created for EmotionDesign on 26.01.2023
//  EmotionContentsView.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import SwiftUI

struct EmotionContentsView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    
    @State private var emotionDTO: EmotionDTO
    @State private var choice: Int
    @State private var updater: Bool
    
    init() {
        _emotionDTO = State(initialValue: EmotionDTO(emotion: SubEmotion(), color: .gray))
        _choice = State(initialValue: -1 )
        _updater = State(initialValue: false)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text("General emotions:")
                        .font(.title2)
                        .textCase(.uppercase)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(dataController.emotionJsonList.indices, id: \.self) { index in
                            Button(action: {
                                choice = index
                                emotionDTO.changeChosenState(to: false)
                            })
                            {
                                VStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(LinearGradient(gradient: Gradient(colors:
                                                                                        choice == index ? dataController.emotionJsonList[index].returnColors() : [.white, .white]),
                                                                 startPoint: .leading,
                                                                 endPoint: .trailing))
                                            .frame(width: 100, height: 100)
                                            .shadow(radius: 5)
                                        Image(dataController.emotionJsonList[index].icon)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipShape(RoundedRectangle(cornerRadius: 20)
                                            )
                                            .frame(width: 100, height: 100)
                                    }
                                    Text(dataController.emotionJsonList[index].name)
                                        .font(.title3)
                                        .textCase(.uppercase)
                                        .bold()
                                        .fixedSize()
                                }
                                .padding()
                                
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
                Divider()
                HStack {
                    Text("Sub emotions:")
                        .font(.title2)
                        .textCase(.uppercase)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal)
                VStack {
                    if ( choice == -1 ) {
                        RoundedRectangle(cornerRadius: 40.0)
                            .stroke(lineWidth: 4.0)
                            .opacity(0)
                    } else {
                        ElementsView(choice: $choice, emotionDTO:  $emotionDTO)
                            .environment(\.managedObjectContext, moc)
                            .environmentObject(dataController)
                    }
                }
            }
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
        .padding()
        .navigationTitle("How are you feeling?")
        //.onAppear(perform: { updater.toggle() })
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

