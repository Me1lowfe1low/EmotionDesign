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
    @State private var selection = 4
    
    var body: some View {
        TabView(selection: $selection)  {
            NotificationView()
                .environment(\.managedObjectContext, moc)
                .environmentObject(dataController)
                .tabItem {
                    Image(systemName: "alarm")
                    Text("Schedule")
                }
                .tag(0)
            InfoView()
                .environment(\.managedObjectContext, moc)
                .environmentObject(dataController)
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Info")
                }
                .tag(1)
            EmotionContentsView()
                .environment(\.managedObjectContext, moc)
                .environmentObject(dataController)
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Main")
                    
                }
                .tag(2)
            Analyze()
                .environment(\.managedObjectContext, moc)
                .environmentObject(dataController)
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Analyze")
                }
                .tag(3)
            HomeScreen()
                .tabItem {
                    Image(systemName: "house.circle.fill")
                    Text("Home")
                }
                .tag(4)
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
