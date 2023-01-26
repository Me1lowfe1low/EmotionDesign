//
//  ContentView.swift
//  EmotionDesign
//
//  Created by Дмитрий Гордиенко on 25.01.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            EmotionShareView()
            //Text("Enter your mood")
                .tabItem {
                    Image(systemName: "plus")
                    Text("Main")
                }
            Text("Information")
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Info")
                }
            Image(systemName: "chart.pie")
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
