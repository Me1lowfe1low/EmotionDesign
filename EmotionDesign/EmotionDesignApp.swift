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
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .environmentObject(dataController)
            }
        }
    }
}

