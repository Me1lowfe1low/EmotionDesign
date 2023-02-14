// Created for EmotionDesign on 25.01.2023
//  EmotionShareView.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import SwiftUI

struct EmotionShareView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    private let emotionJsonList: [InitialEmotion] = Bundle.main.decode([InitialEmotion].self, from: "EmotionInitialList.json")
    
    var body: some View {
        NavigationLink(destination:
                        EmotionContentsView()
            .environment(\.managedObjectContext, moc)
            .environmentObject(dataController)
        ) {
            ZStack {
                LinearGradient(colors:
                    getColorList(), startPoint: .top, endPoint: .trailing)
                .scaledToFit()
                .mask(
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFit()
                        .padding()
                )
            }
        }
    }
    
    func getColorList() -> [Color] {
        var colorList = [Color]()
        emotionJsonList.forEach { element in
            colorList.append(element.getColor())
            colorList.append(element.getAccentColor())
        }
        return colorList
    }
}

struct EmotionShareView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionShareView()
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .environmentObject(DataController.preview)
    }
}
