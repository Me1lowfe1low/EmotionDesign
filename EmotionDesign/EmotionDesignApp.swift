// Created for EmotionDesign 25.01.2023
//  EmotionDesignApp.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes


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

