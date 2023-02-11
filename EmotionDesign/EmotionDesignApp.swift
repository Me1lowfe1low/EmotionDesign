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
import CoreData

@main
struct EmotionDesignApp: App {
    let container = NSPersistentContainer(name: "EmotionDesign")
    
    var body: some Scene {
        WindowGroup {
            let context = container.viewContext
            let dataController = DataController(context, container: container)
            
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, context)
                    .environmentObject(dataController)
            }
        }
    }
}

