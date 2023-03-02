// Created for EmotionDesign on 08.02.2023
//  Analyze.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import SwiftUI

struct Analyze: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DayDetail.date, ascending: true)]) var userDataSet: FetchedResults<DayDetail>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DayDetail.date, ascending: false)]) var userDataSetOrdered: FetchedResults<DayDetail>
    
    @State var chartList: ChartController = ChartController()
    @State var chosenDateFilter: ChartFilter = ChartFilter(7)
    @State private var isConfirmed: Bool = false
    
    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Spacer()
                ScrollView(.vertical) {
                    ChartView(filter: $chosenDateFilter)
                    VStack {
                        HStack(spacing: 20) {
                            Text("Journal")
                                .font(.title2)
                                .bold()
                                .textCase(.uppercase)
                                .padding(.horizontal)
                            Spacer()
                            Text ("date")
                                .font(.caption)
                                .textCase(.uppercase)
                                .padding(.horizontal)
                        }
                        .padding()
                        VStack {
                            ForEach(userDataSetOrdered, id: \.self ) { day in
                                EmotionJournalEntryView(day: day, filter: $chosenDateFilter)
                            }
                            .padding(.vertical)
                        }
                        .padding(.horizontal)
                        Spacer()
                    }
                    .background(RoundedRectangle(cornerRadius: 40)
                        .fill(Color(UIColor.secondarySystemBackground))
                        .shadow(color: Color(UIColor.systemFill) ,radius: 5))
                    .padding()
                }

                Button(role: .destructive) { isConfirmed = true }
            label:
                {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(UIColor.secondarySystemBackground))

                        .frame(height: 50 ,alignment: .center)
                        .shadow(color: Color(UIColor.systemFill) ,radius: 5)
                        .padding()
                        .overlay(
                            Text("Clear all data")
                                .textCase(.uppercase)
                                .font(.title3)
                                .bold()
                                .fixedSize()
                                .scaledToFit()
                        )
                }
                .confirmationDialog("ARE YOU SURE?", isPresented: $isConfirmed ) {
                    Button("CLEAR", role: .destructive)
                    {
                        clearData()
                    }
                }
            }
            .padding()
        }
    }
        
    func clearData() {
        dataController.clearData(moc, data: userDataSet)
    }

}


/*struct Analyze_Previews: PreviewProvider {
    static var previews: some View {
        Analyze().preferredColorScheme(.dark)
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .environmentObject(DataController.preview)
    }
}*/




