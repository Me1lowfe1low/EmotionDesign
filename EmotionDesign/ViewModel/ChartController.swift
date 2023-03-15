// Created for EmotionDesign on 23.02.2023
//  ChartController.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import Foundation
import OSLog
import SwiftUI

class ChartController: ChartControllerProtocol {
    @Published var charts: [EmotionChart]
    
    private let emotionJsonList: [InitialEmotion]
    private let logger: Logger
    
    init() {
        self.charts = []
        self.logger = Logger(subsystem: "EmotionDesign", category: "ChartData")
        self.emotionJsonList = Bundle.main.decode([InitialEmotion].self, from: "EmotionInitialList.json")
    }
}

protocol ChartControllerProtocol {
    var charts: [EmotionChart] { set get }
    
    func createChartTemplate()
    func getCharts() -> [EmotionChart]
    func chartIsEmpty(_ index: Int) -> Bool
    func getChartPoints(_ index: Int) -> [ChartPoint]
    func getChartColor(_ index: Int) -> Color
    func getChartTitle(_ index: Int) -> String
    func fillChartTemplate(days: FetchedResults<DayDetail>)
}

extension ChartController {
    
    func createChartTemplate() {
        logger.debug("Creating chart template")
        if charts.isEmpty {
            emotionJsonList.forEach { emotion in
                let tempTitle = "\(emotion.name.capitalized) chart"
                let emotionChart: EmotionChart = EmotionChart(title: tempTitle, emotion: emotion.name, color: emotion.getColor())
                self.charts.append(emotionChart)
            }
        }
    }
    
    func getCharts() -> [EmotionChart] {
        logger.debug("getCharts: returning charts")
        return charts
    }
    
    func chartIsEmpty(_ index: Int) -> Bool {
        guard charts.count > index else {
            logger.error("chartIsEmpty: index is out of range: \(index)")
            return false
        }
        logger.debug("chartIsEmpty: \(self.charts[index].points.isEmpty)")
        return charts[index].points.isEmpty
    }
    
    func getChartPoints(_ index: Int) -> [ChartPoint] {
        guard charts.count > index else {
            logger.error("getChartPoints: index is out of range: \(index)")
            return []
        }
        return charts[index].points
    }
    
    func getChartColor(_ index: Int) -> Color {
        guard charts.count > index else {
            logger.error("getChartColor: index is out of range: \(index)")
            return Color(UIColor.link)
        }
        logger.debug("getChartColor: \(self.charts[index].color)")
        return charts[index].color
    }
    
    func getChartTitle(_ index: Int) -> String {
        guard charts.count > index else {
            logger.error("getChartTitle: index is out of range: \(index)")
            return "Chart"
        }
        logger.debug("getChartTitle: \(self.charts[index].title)")
        return charts[index].title
    }
    
    func fillChartTemplate(days: FetchedResults<DayDetail>) {
        days.forEach { day in
            logger.debug("Current date: \(day.getDate())")
            for ind in 0..<charts.count {
                var tempIndex = 0
                if charts[ind].points.firstIndex(where: { Calendar.current.isDate(  $0.date , equalTo: day.wrappedDate, toGranularity: .day ) }) == nil  {
                    
                    logger.debug("Creating point for date: \(day.getDate())")
                    charts[ind].addPoint(day.wrappedDate)
                    
                    logger.debug("Added new point:")
                    logger.debug("day: \(self.charts[ind].points.last!.getDate()), value: \(self.charts[ind].points.last!.count), emotion: \(self.charts[ind].emotion)")
                    tempIndex = charts[ind].points.firstIndex(where: { Calendar.current.isDate(  $0.date , equalTo: day.wrappedDate, toGranularity: .day ) })!
                } else {
                    tempIndex = charts[ind].points.firstIndex(where: { Calendar.current.isDate(  $0.date , equalTo: day.wrappedDate, toGranularity: .day ) })!
                    
                    logger.debug("Saved index: \(tempIndex)")
                }
                
                // Check users data unique emotions
                day.uniqueMainEmotion.forEach { element in
                    if charts[ind].emotion == emotionJsonList[element.key].name {
                        charts[ind].points[tempIndex].setValue(element.value)
                        
                        logger.info("Changed point:")
                        logger.debug("Date: \(self.charts[ind].points[tempIndex].getDate()), value: \(self.charts[ind].points[tempIndex].count ), emotion: \(self.charts[ind].emotion)")
                    }
                }
            }
        }
        print(self.charts)
        logger.debug("Chart was filled with data")
    }
}
