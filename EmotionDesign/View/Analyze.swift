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
import Charts

struct Analyze: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DayDetail.date, ascending: true)]) var userDataSet: FetchedResults<DayDetail>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DayDetail.date, ascending: false)]) var userDataSetOrdered: FetchedResults<DayDetail>
    
    @State var chartList: ChartController = ChartController()
    @State private var currentDate: Date = Date()
    @State private var isConfirmed: Bool = false
    @State var selectionName: String = "Chart"
    @State var selectionId: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Menu {
                    ForEach( chartList.charts.indices, id: \.self) { chartId in
                        Button(action: { selectionId = chartId
                            selectionName = chartList.charts[chartId].title
                        } ) {
                            Text(chartList.charts[chartId].title)
                                .bold()
                                .font(.title3)
                        }
                    }
                } label: {
                    Image(systemName: "list.bullet")
                        .frame(alignment: .trailing)
                }
            }
            Section(header: Text(selectionName)
                .font(.caption)
                .textCase(.uppercase)
                .padding(.vertical)
                    
            ){
                VStack  {
                    if selectionId != nil {
                        VStack {
                            if !chartList.charts[selectionId!].points.isEmpty {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                                    .frame(height: 250 ,alignment: .center)
                                    .shadow(radius: 5)
                                    .padding()
                                    .overlay(
                                        Chart {
                                            ForEach( chartList.charts[selectionId!].points.prefix(7), id: \.self) { point in
                                                LineMark(x: .value("Date", point.getDate()),
                                                         y: .value("Total count", point.count))
                                                PointMark(x: .value("Date", point.getDate()),
                                                         y: .value("Total count", point.count))
                                            }
                                        }
                                            .frame(width: 200, height: 200 ,alignment: .center)
                                            .foregroundStyle(chartList.charts[selectionId!].color)
                                            .chartXAxisLabel("Date")
                                            .chartYAxisLabel("Counts")
                                    )
                            }
                            else {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.white)
                                        .frame(height: 250 ,alignment: .center)
                                        .shadow(radius: 5)
                                        .padding()
                                        .overlay(
                                            Text("Currently there is no data in this chart")
                                                .font(.caption2)
                                                .bold()
                                                .fixedSize()
                                                .scaledToFit()
                                        )
                                }
                            }
                        }
                    }
                    else {
                        RoundedRectangle(cornerRadius: 20)
                             .fill(.white)
                             .frame(height: 250 ,alignment: .center)
                             .shadow(radius: 5)
                             .padding()
                             .overlay(
                                 Text("You may look through your weekly \n emotion statistics by clicking \n on the bullet list \n at the top right corner")
                                     .font(.caption2)
                                     .bold()
                                     .padding()
                                     .multilineTextAlignment(.center)
                             )
                    }
                }
                .onAppear(perform: { chartList = dataController.getChartData(moc, days: userDataSet)
                })
            }
            .padding(.horizontal)
            Section(header: Text("Journal")
                .font(.caption)
                .textCase(.uppercase)
            ){
                ScrollView(.vertical) {
                    ForEach(userDataSetOrdered, id: \.self ) { day in
                        ForEach(day.emotions, id: \.self) { emotion in
                            HStack(spacing: 20) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.white)
                                        .frame(width: 90, height: 90, alignment: .leading)
                                        .shadow(radius: 5)
                                    Image(dataController.emotionJsonList[Int(emotion.parent)].findEmotionIcon(emotion.name!))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(RoundedRectangle(cornerRadius:  20))
                                        .frame(width: 90, height: 90)
                                }
                                VStack(alignment: .leading) {
                                    Text(emotion.name!)
                                        .font(.caption)
                                        .foregroundColor(dataController.emotionJsonList[Int(emotion.parent)].getColor())
                                        .textCase(.uppercase)
                                        .bold()
                                    Text(emotion.comment!)
                                        .font(.caption)
                                }
                                Spacer()
                                Text(day.getDate())
                                    .font(.caption)
                            }
                            .padding()
                        }
                    }
                }
            }
            .padding()
            
            
            Button(role: .destructive) { isConfirmed = true }
        label:
            {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(height: 50 ,alignment: .center)
                    .shadow(radius: 5)
                    .padding()
                    .overlay(
                        Text("Clear all data")
                            .font(.caption2)
                            .bold()
                            .fixedSize()
                            .scaledToFit()
                    )
            }
            .confirmationDialog("Are you sure?", isPresented: $isConfirmed ) {
                Button("Clear", role: .destructive)
                {
                    clearData()
                }
            }
        }
        .padding()
    }
        
    
    func clearData() {
        dataController.clearData(moc, data: userDataSet)
    }
    
    
    /*func delete(at offsets: IndexSet) {
        for offset in offsets {
            dataController.delete(moc, day: userDataSet[offset])
        }
    }*/
}




struct Analyze_Previews: PreviewProvider {
    static var previews: some View {
        Analyze()
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .environmentObject(DataController.preview)
    }
}


struct ListButtonView: View {
    var body: some View {
        Text("")
    }
}




struct EmotionChart: Identifiable {
    var id: UUID = UUID()
    var title: String
    var emotion: String
    var color: Color
    var points: [ChartPoint] = []
    
    mutating func addPoint(_ date: Date) {
        points.append(ChartPoint(date: date))
    }

}

struct ChartPoint: Identifiable, Hashable {
    var id: UUID = UUID()
    var date: Date
    var count: Int = 0
    
    mutating func increment() {
        self.count += 1
    }
    
    mutating func setValue(_ value: Int) {
        self.count = value
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter.string(from: date)
    }
}
