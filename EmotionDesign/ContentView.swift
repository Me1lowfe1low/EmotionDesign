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
    @StateObject var userData: UserDetails = UserDetails()
    
    var body: some View {
        TabView {
            EmotionShareView()
                .environmentObject(userData)
                .tabItem {
                    Image(systemName: "plus")
                    Text("Main")
                }
            Info()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Info")
                }
            Analyze()
                .environmentObject(userData)
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Analyze")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
