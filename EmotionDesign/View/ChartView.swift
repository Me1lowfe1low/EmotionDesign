// Created for EmotionDesign on 28.02.2023
//  ChartView.swift
//  EmotionDesign
//
//
//    dmgordienko@gmail.com 2023

import SwiftUI
import Charts

struct ChartView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DayDetail.date, ascending: true)]) var userDataSet: FetchedResults<DayDetail>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DayDetail.date, ascending: false)]) var userDataSetOrdered: FetchedResults<DayDetail>
    
    @State var chartList: ChartController = ChartController()
    @State var selectionName: String = "Chart"
    @State var selectionId: Int?
    @State var position: ChartPoint?
    @State var currentTab: String = "7 days"
    @Binding var filter: ChartFilter
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
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
                            .foregroundColor(selectionName == "Chart" ? Color(UIColor.link) : chartList.charts[selectionId!].color )
                            .fixedSize()
                            .font(.title2)
                            .bold()
                            .textCase(.uppercase)
                            .padding(.horizontal)
                        Spacer()
                    }
                    .padding()
                }
                Picker("", selection: $currentTab) {
                    Text("7 Days")
                        .frame(width: 100)
                        .font(.title3)
                        .textCase(.uppercase)
                        .tag("7 days")
                    Text("Whole history")
                        .frame(width: 100)
                        .font(.title3)
                        .textCase(.uppercase)
                        .tag("Whole history")
                }
                .onChange(of: currentTab) { tag in
                    if tag == "Whole history" { filter = ChartFilter() }  else  { filter = ChartFilter(7) }
                    dataController.logger.debug("\(filter.getDate())")
                }
                .padding(.horizontal)
                .pickerStyle(.segmented)
            }
            VStack  {
                if selectionId != nil {
                    VStack {
                        if !chartList.charts[selectionId!].points.isEmpty {
                            Chart(chartList.charts[selectionId!].points) { point in
                                if filter.contains(point.date) {
                                    LineMark(x: .value("Date", point.getDate()),
                                             y: .value("Total count", point.count))
                                    .interpolationMethod(.monotone)
                                    AreaMark(x: .value("Date", point.getDate()),
                                             y: .value("Total count", point.count))
                                    .interpolationMethod(.monotone)
                                    .foregroundStyle(chartList.charts[selectionId!].color.opacity(0.2).gradient)
                                    PointMark(x: .value("Date", point.getDate()),
                                              y: .value("Total count", point.count))
                                }
                            }
                            .frame(height: 220, alignment: .center)
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
            .frame(height: 250, alignment: .center)
            .onAppear(perform: { chartList = dataController.getChartData(moc, days: userDataSet)
            })
        }
        .background(RoundedRectangle(cornerRadius: 40)
            .fill(Color(UIColor.secondarySystemBackground))
            .shadow(color: Color(UIColor.systemFill) ,radius: 5))
        .padding()
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(filter: .constant(ChartFilter()))
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .environmentObject(DataController.preview)
    }
}
