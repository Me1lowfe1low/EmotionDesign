// Created for EmotionDesign on 25.02.2023
//  EmotionView.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import SwiftUI

struct EmotionView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    @Binding var position: PositionDTO
    
    
    var body: some View {
        HStack {
            if position.position == .right {
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: position.getRadius())
                    .fill(.white)
                    .frame(width: position.getSize(), height: position.getSize())
                    .shadow(radius: 25)
                Image(dataController.emotionJsonList[position.elementId].icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: position.getRadius())
                    )
                    .frame(width: position.getSize(), height: position.getSize())
            }
            if position.position == .left {
                Spacer()
            }
        }
        .padding()
    }
}
struct EmotionView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionView(position: .constant(PostitionListDTO().positionList[1]))
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .environmentObject(DataController.preview)
    }
}
