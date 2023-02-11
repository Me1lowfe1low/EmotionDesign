// Created for EmotionDesign on 08.02.2023
//  Analyze.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import SwiftUI

struct Analyze: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DayDetail.date, ascending: false)]) var userDataSet: FetchedResults<DayDetail>
    private let emotionJsonList: [InitialEmotion] = Bundle.main.decode([InitialEmotion].self, from: "EmotionInitialList.json")
    
    @State private var currentDate: Date = Date()
    
    var body: some View {
        VStack {
            Form {
                Section("Days picture") {
                    ForEach(userDataSet, id: \.self ) { day in
                        LazyVGrid(columns: [GridItem(.flexible())]) {
                            HStack( alignment: .top) {
                                ZStack {
                                    ForEach(day.emotions , id: \.self) { emotion in
                                        AnimatedCircle(emotion: emotionJsonList[emotion.wrappedParent] )
                                    }
                                }
                                .frame(width: 100, height: 100)
                                .padding()
                                Spacer()
                                VStack(alignment: .leading) {
                                    Section(header: Text(day.wrappedDate, style: .date)) {
                                        Text("You felt: ")
                                        ForEach(day.uniqueEmotion , id: \.key) { emotion in
                                            Text(emotion.key)
                                                .frame(alignment: .center)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Section("Whole picture")
            {
                ZStack {
                    ForEach(userDataSet, id: \.self ) { day in
                        HStack {
                            ForEach(day.emotions, id: \.self) { emotion in
                                AnimatedCircle(emotion: emotionJsonList[emotion.wrappedParent])
                            }
                        }
                        .padding()
                    }
                }
            }
            .padding()
            Button("Clear all data") {
                clearData()
            }
        }
    }
    
    func clearData() {
        dataController.clearData(moc, data: userDataSet)
    }
}

struct Analyze_Previews: PreviewProvider {
    static var previews: some View {
        Analyze()
    }
}
