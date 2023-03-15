// Created for EmotionDesign on 18.02.2023
//  InfoView.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import SwiftUI

struct InfoView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataOrchestrator: DataOrchestrator

    @State var emotionsView = PostitionListDTO()
    @State private var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Text("Emotion description")
                    .font(.title)
                    .textCase(.uppercase)
                    .padding()
                HStack {
                    ZStack {
                        ForEach($emotionsView.positionList, id: \.id) { $emotion in
                            EmotionView(position: $emotion)
                                .frame(alignment: emotion.position.alignment)
                                .animation(.easeInOut, value: 2)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            offset = CGSize(width: gesture.translation.width,  height: 0)
                                        }
                                        .onEnded { _ in
                                            if offset.width < 0 {
                                                offset = CGSize.zero
                                                emotionsView.moveLeft()
                                            } else {
                                                offset = CGSize.zero
                                                emotionsView.moveRight()
                                            }
                                        }
                                )
                            
                        }
                    }
                }
                Text(dataOrchestrator.emotionJsonList[emotionsView.positionList.last!.elementId].name)
                    .font(.title2)
                    .foregroundColor(dataOrchestrator.emotionJsonList[emotionsView.positionList.last!.elementId].getColor())
                    .bold()
                    .shadow(color: Color(UIColor.systemFill) ,radius: 5)
                    .textCase(.uppercase)
                    .padding()
                Text(dataOrchestrator.emotionJsonList[emotionsView.positionList.last!.elementId].description)
                    .font(.title3)
                    .padding()
                Spacer()
            }
            .padding()
        }
    }
    
    
}


/*struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .environment(\.managedObjectContext, CoreDataManipulator.preview.container.viewContext)
            .environmentObject(DataController.preview)
    }
}*/
