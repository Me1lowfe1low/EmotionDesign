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
    
    var body: some View {
        NavigationLink(destination:
                        EmotionContentsView()
            .environment(\.managedObjectContext, moc)
            .environmentObject(dataController)
        ) {
            ZStack {
                Circle()
                    .stroke(.white, lineWidth: 4)
                    .padding()
                Circle()
                    .padding()
                    .opacity(0.8)
                    .blendMode(.destinationOut)
                    .overlay(
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                    )
            }
        }
    }
}

struct EmotionShareView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionShareView()
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .environmentObject(DataController.preview)
    }
}
