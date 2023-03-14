// Created for EmotionDesign 25.01.2023
//  ContentView.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: FunctionLayer //DataController
    @State private var selection = 0
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DayDetail.date, ascending: true)]) var userDataSet: FetchedResults<DayDetail>
    
    var body: some View {
        TabView(selection: $selection)  {
            HomeScreen()
                .tabItem {
                    Image(systemName: "house.circle.fill")
                    Text("Home")
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
            NotificationView()
                .environment(\.managedObjectContext, moc)
                .environmentObject(dataController)
                .tabItem {
                    Image(systemName: "alarm")
                    Text("Schedule")
                }
                .tag(4)
        }
        .onAppear(perform: { dataController.getChartData(days: userDataSet)
        })
    }
}

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .environmentObject(DataController.preview)
    }
}*/
