// Created for EmotionDesign 25.01.2023
//  ContentView.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        TabView  {
            Text("Schedule")
                .tabItem {
                    Image(systemName: "alarm")
                    Text("Schedule")
                }
            //Info()
            InfoView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Info")
                }
            Analyze()
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Analyze")
                }
            //EmotionShareView()
            EmotionContentsView()
                .environment(\.managedObjectContext, moc)
                .environmentObject(dataController)
                .tabItem {
                    Image(systemName: "plus")
                    Text("Main")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .environmentObject(DataController.preview)
    }
}
