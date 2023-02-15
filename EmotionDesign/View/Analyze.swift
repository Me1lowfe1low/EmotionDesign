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
    @State private var isConfirmed: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Section(header: Text("Days picture")
                .font(.caption)
                .textCase(.uppercase)
            ) {
                List {
                    ForEach(userDataSet, id: \.self ) { day in
                        LazyVGrid(columns: [GridItem(.flexible())]) {
                            HStack( alignment: .top) {
                                ZStack {
                                    ForEach(day.emotions , id: \.self) { emotion in
                                        AnimatedCircle( emotion: emotionJsonList[emotion.wrappedParent] )
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
                    .onDelete(perform: delete)
                }
            }
            .padding()
            Section(header: Text("Whole picture")
                .font(.caption)
                .textCase(.uppercase)
            ){
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
            Button("Clear all data", role: .destructive) {
                isConfirmed = true
            }
            .confirmationDialog("Are you sure?", isPresented: $isConfirmed ) {
                Button("Clear", role: .destructive)
                {
                    clearData()
                }
            }
            .padding()
        }
        .padding()
    }
    
    func clearData() {
        dataController.clearData(moc, data: userDataSet)
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            dataController.delete(moc, day: userDataSet[offset])
        }
    }

}

struct Analyze_Previews: PreviewProvider {
    static var previews: some View {
        Analyze()
    }
}
