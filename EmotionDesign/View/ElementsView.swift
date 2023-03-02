// Created for EmotionDesign on 10.02.2023
//  ElementsView.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import SwiftUI

struct ElementsView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    @Binding var choice: Int
    @Binding var emotionDTO: EmotionDTO

    
    var body: some View {
        ZStack {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(dataController.emotionJsonList[choice].subEmotions, id: \.id) { emotion in
                        Button(action: { emotionDTO.setEmotion(emotion, color: dataController.emotionJsonList[choice].getColor(), chosen: true)
                        })
                        {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(LinearGradient(gradient: Gradient(colors:
                                                                            emotionDTO.getColor(emotion.name,colorSet: dataController.emotionJsonList[choice].returnColors())),
                                               startPoint: .leading,
                                               endPoint: .trailing))
                                .frame(width: 100, height: 100 ,alignment: .center)
                                .shadow(color: Color(UIColor.systemFill) ,radius: 5)
                                .overlay(
                                    Text(emotion.name)
                                        .font(.caption)
                                        .textCase(.uppercase)
                                        .bold()
                                        .fixedSize()
                                        .scaledToFit()
                                        .shadow(color: Color(UIColor.systemFill) ,radius: 5)
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding()
                }
        }
        .background(Color(UIColor.secondarySystemBackground))
    }
}

struct ElementsView_Previews: PreviewProvider {
    static var previews: some View {
        ElementsView(choice: .constant(0), emotionDTO: .constant(EmotionDTO(emotion: SubEmotion(), color: .green)))
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .environmentObject(DataController.preview)
    }
}
