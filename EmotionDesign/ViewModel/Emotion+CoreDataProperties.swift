// Created for EmotionDesign on 10.02.2023
//  Emotion+CoreDataProperties.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import Foundation
import CoreData


extension Emotion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Emotion> {
        return NSFetchRequest<Emotion>(entityName: "Emotion")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var parent: Int32
    @NSManaged public var comment: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var day: DayDetail?
    
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedName: String {
        name ?? ""
    }

    public var wrappedParent: Int {
        Int(parent)
    }
    
    public var wrappedTimestamp: Date {
        timestamp ?? Date()
    }
    
    public var wrappedComment: String {
        comment ?? ""
    }
}

extension Emotion : Identifiable {

}
