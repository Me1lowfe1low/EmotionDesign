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
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DayDetail.date, ascending: false)]) var userDataSet: FetchedResults<DayDetail>
    
    var body: some View {
        TabView  {
            EmotionShareView()
                .environment(\.managedObjectContext, moc)
                .environmentObject(dataController)
                .tabItem {
                    Image(systemName: "plus")
                    Text("Main")
                }
            Info()
                .environment(\.managedObjectContext, moc)
                .environmentObject(dataController)
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Info")
                }
            Analyze()
                .environment(\.managedObjectContext, moc)
                .environmentObject(dataController)
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Analyze")
                }
        }
    }
}
