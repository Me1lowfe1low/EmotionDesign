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
    @EnvironmentObject var dataController: FunctionLayer //DataController
    
    @State var selectionName: String = "Chart"
    @State var selectionId: Int? = nil
    @State var position:ChartPoint?
    @State var currentTab: String = "7 days"
    @Binding var filter:ChartFilter
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Menu {
                    ForEach( dataController.getEmotionCharts().indices, id: \.self) { chartId in
                        Button(action: { selectionId = chartId
                            selectionName = dataController.getChartTitle(chartId)
                            dataController.logger.debug("Selection name: \(selectionName)")
                        } ) {
                            Text(dataController.getChartTitle(chartId))
                                .font(.title3)
                                .bold()
                        }
                    }
                } label: {
                    HStack(spacing: 20) {
                        Text(selectionName)
                            .foregroundColor(dataController.getChartColor(selectionName, index: selectionId)
                                )
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
                    filter = dataController.getChartPeriod(tag)
                }
                .padding(.horizontal)
                .pickerStyle(.segmented)
            }
            VStack  {
                if selectionId != nil {
                    VStack {
                        if !dataController.chartIsEmpty(selectionId) {
                            Chart(dataController.getChartPoints(selectionId)) { point in
                                if filter.contains(point.date) {
                                    LineMark(x: .value("Date", point.getDate()),
                                             y: .value("Total count", point.count))
                                    .interpolationMethod(.monotone)
                                    AreaMark(x: .value("Date", point.getDate()),
                                             y: .value("Total count", point.count))
                                    .interpolationMethod(.monotone)
                                    .foregroundStyle(dataController.getChartColor(selectionId).opacity(0.2).gradient)
                                    PointMark(x: .value("Date", point.getDate()),
                                              y: .value("Total count", point.count))
                                }
                            }
                            .frame(height: 220, alignment: .center)
                            .foregroundStyle(dataController.getChartColor(selectionId))
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
        }
        .background(RoundedRectangle(cornerRadius: 40)
            .fill(Color(UIColor.secondarySystemBackground))
            .shadow(color: Color(UIColor.systemFill) ,radius: 5))
        .padding()
    }
}

/*struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(filter: .constant(ChartFilter()))
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .environmentObject(DataController.preview)
    }
}*/
