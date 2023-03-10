// Created for EmotionDesign 25.01.2023
//  EmotionDesignApp.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//


import SwiftUI

@main
struct EmotionDesignApp: App {

    var body: some Scene {
        WindowGroup {
            let dataController = DataController()
            let dataManipulator = FunctionLayer(mainContext: dataController.container.viewContext)
            
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    //.environment(\.managedObjectContext, dataManipulator.mainContext)
                    .environmentObject(dataManipulator)
            }
        }
    }
}

