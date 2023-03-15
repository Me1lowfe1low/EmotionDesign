// Created for EmotionDesign on 25.02.2023
//  EmotionView.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import SwiftUI

struct EmotionView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataOrchestrator: DataOrchestrator 
    @Binding var position: PositionDTO
    
    
    var body: some View {
        HStack {
            if position.position == .right {
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: position.getRadius())
                    .fill(Color(UIColor.secondarySystemBackground))
                    .frame(width: position.getSize(), height: position.getSize())
                    .shadow(color: Color(UIColor.systemFill) ,radius: 10)
                Image(dataOrchestrator.emotionJsonList[position.elementId].icon)
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

/*struct EmotionView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionView(position: .constant(PostitionListDTO().positionList[1]))
            .environment(\.managedObjectContext, CoreDataManipulator.preview.container.viewContext)
            .environmentObject(DataController.preview)
    }
}*/
