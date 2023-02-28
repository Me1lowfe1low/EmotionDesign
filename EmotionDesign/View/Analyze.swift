// Created for EmotionDesign on 08.02.2023
//  Analyze.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

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
    @State var color: Color = Color.accentColor
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Spacer()
                ScrollView(.vertical) {
                    VStack(spacing: 20) {
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
                            HStack(spacing: 20) {
                                Text(selectionName)
                                    .font(.title2)
                                    .bold()
                                    .textCase(.uppercase)
                                    .padding(.horizontal)
                                    //.foregroundStyle(selectionId != nil ? chartList.charts[selectionId!].color : color)
                                    .foregroundStyle(.black)
                                Spacer()
                            }
                            .padding()
                        }
                        
                        
                        VStack  {
                            if selectionId != nil {
                                VStack {
                                    if !chartList.charts[selectionId!].points.isEmpty {
                                        Chart(chartList.charts[selectionId!].points.prefix(7)) { point in
                                            LineMark(x: .value("Date", point.getDate()),
                                                     y: .value("Total count", point.count))
                                            PointMark(x: .value("Date", point.getDate()),
                                                      y: .value("Total count", point.count))
                                        }
                                        .frame(height: 220 ,alignment: .center)
                                        .foregroundStyle(chartList.charts[selectionId!].color)
                                        .chartXAxisLabel("Date")
                                        .chartYAxisLabel("Counts")
                                        .padding()
                                    }
                                    else {
                                        ZStack {
                                            Text("Currently there is no data in this chart")
                                                .font(.caption2)
                                                .bold()
                                                .fixedSize()
                                                .scaledToFit()
                                                //.frame(height: 250 ,alignment: .center)
                                        }
                                    }
                                }
                            }
                            else {
                                Text("You may look through your weekly \n emotion statistics by clicking\n on the name of the chart\n at the top left corner.")
                                    .font(.title3)
                                    .bold()
                                    .padding()
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .frame(height: 250 ,alignment: .center)
                        .onAppear(perform: { chartList = dataController.getChartData(moc, days: userDataSet)
                        })
                    }
                    .background(RoundedRectangle(cornerRadius: 40)
                        .fill(.white)
                        .shadow(radius: 5))
                    .padding()
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
                                ForEach(day.emotions, id: \.self) { emotion in
                                    HStack(spacing: 10) {
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
                                                .font(.title3)
                                                .foregroundColor(dataController.emotionJsonList[Int(emotion.parent)].getColor())
                                                .textCase(.uppercase)
                                                .fixedSize()
                                                .bold()
                                            Text(emotion.comment!)
                                                .font(.caption)
                                        }
                                        Spacer()
                                        Text(day.getDate())
                                            .font(.caption2)
                                            .fixedSize()
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.vertical)
                        }
                        .padding(.horizontal)
                        Spacer()
                    }
                    .background(RoundedRectangle(cornerRadius: 40)
                        .fill(.white)
                        .shadow(radius: 5))
                    .padding()
                }

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
                                .font(.title3)
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
    }
        
        
    
    func clearData() {
        dataController.clearData(moc, data: userDataSet)
    }
    

}


struct Analyze_Previews: PreviewProvider {
    static var previews: some View {
        Analyze()
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .environmentObject(DataController.preview)
    }
}




