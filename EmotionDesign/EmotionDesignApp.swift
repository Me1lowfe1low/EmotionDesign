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
            let coreDataManipulator = CoreDataManipulator()
            let dataOrchestrator = DataOrchestrator(coreDataManipulator)
            
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, coreDataManipulator.container.viewContext)
                    .environmentObject(dataOrchestrator)
            }
        }
    }
}

