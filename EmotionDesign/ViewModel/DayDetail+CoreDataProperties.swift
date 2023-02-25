// Created for EmotionDesign on 10.02.2023
//  DayDetail+CoreDataProperties.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 
//

import Foundation
import CoreData


extension DayDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayDetail> {
        return NSFetchRequest<DayDetail>(entityName: "DayDetail")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var comment: String?
    @NSManaged public var emotion: NSSet?

    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedDate: Date {
        date ?? Date()
    }
    
    public var wrappedComment: String {
        comment ?? ""
    }
    
    public var emotions: [Emotion] {
        let set = emotion as? Set<Emotion> ?? []
        
        return set.sorted {
            $0.wrappedTimestamp < $1.wrappedTimestamp
        }
    }
    
    public var uniqueEmotion: [(key: String,value: Int)] {
        let set = emotion as? Set<Emotion> ?? []
        let counts = set.reduce(into: [:]) { counts, element in
            counts[element.wrappedName, default: 0] += 1
        }
        return counts.sorted {
            $0.key < $1.key
        }
    }
    
    public var uniqueMainEmotion: [(key: Int,value: Int)] {
        let set = emotion as? Set<Emotion> ?? []
        let counts = set.reduce(into: [:]) { counts, element in
            counts[element.wrappedParent, default: 0] += 1
        }
        return counts.sorted {
            $0.key < $1.key
        }
    }
}

// MARK: Generated accessors for emotion
extension DayDetail {

    @objc(addEmotionObject:)
    @NSManaged public func addToEmotion(_ value: Emotion)

    @objc(removeEmotionObject:)
    @NSManaged public func removeFromEmotion(_ value: Emotion)

    @objc(addEmotion:)
    @NSManaged public func addToEmotion(_ values: NSSet)

    @objc(removeEmotion:)
    @NSManaged public func removeFromEmotion(_ values: NSSet)

}

extension DayDetail : Identifiable {

    /*func fillDataForCharts() -> [ChartPoint] {
        //var chartDetails: [ChartPoint] = []
        let set = emotion as? Set<Emotion> ?? []
        let counts = set.reduce(into: [:]) { counts, element in
            counts[element.wrappedParent, default: 0] += 1
        }
        var chartDetails: [ChartPoint] = counts.map { ChartPoint(date: self.wrappedDate, color: .red, count: $0.value , emotion: $0.key ) }
    }*/
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter.string(from: date!)
    }
}
