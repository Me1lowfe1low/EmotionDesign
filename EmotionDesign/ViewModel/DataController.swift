// Created for EmotionDesign on 09.02.2023
//  DataController.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import CoreData
import Foundation
import SwiftUI

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "EmotionDesign")
    
    
    static var preview: DataController {
        let storage = DataController(inMemory: true)
        
        let emotionDTO = EmotionDTO(emotion: SubEmotion.emotionSample, color: .yellow)
        storage.createAndFillNewDayEntry(storage.container.viewContext, element: emotionDTO, comment: "No comments", date: Date())
        
        return storage
    }
 
    
    init(inMemory: Bool = false) {
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addEmotionEntryToDay(_ context: NSManagedObjectContext,day: DayDetail, element: EmotionDTO, comment: String, date: Date) {
        let emotion = Emotion(context: context)
        emotion.id = element.emotion.id
        emotion.name = element.emotion.name
        emotion.parent = Int32(element.emotion.parent)
        emotion.comment = comment
        emotion.timestamp = date
        emotion.day = day
        emotion.day?.id = day.wrappedId
        emotion.day?.comment = day.wrappedComment
        emotion.day?.date = day.wrappedDate
        saveContext(context)
    }
    
    func createAndFillNewDayEntry(_ context: NSManagedObjectContext, element: EmotionDTO, comment: String, date: Date) {
        let dayDetails = DayDetail(context: context)
        dayDetails.id = UUID()
        dayDetails.comment = ""
        dayDetails.date = date
        saveContext(context)
        
        let emotion = Emotion(context: context)
        emotion.id = element.emotion.id
        emotion.name = element.emotion.name
        emotion.parent = Int32(element.emotion.parent)
        emotion.comment = comment
        emotion.timestamp = date
        emotion.day = dayDetails
        saveContext(context)
    }
    
    func delete(_ context: NSManagedObjectContext, day: DayDetail ) {
        context.delete(day)
        saveContext(context)
    }
    
    func saveData(_ context: NSManagedObjectContext, data: FetchedResults<DayDetail>, element: EmotionDTO, comment: String, date: Date) {
        guard data.first == nil else {
            var dateFound = false
            data.forEach {
                if Calendar.current.isDate( $0.wrappedDate , equalTo: Date(), toGranularity: .day ) {
                    dateFound = true
                    addEmotionEntryToDay(context,day: $0, element: element, comment: comment, date: date)
                }
            }
            if dateFound == false {
                createAndFillNewDayEntry(context, element: element, comment: comment, date: date)
            }
            
            return
        }
        createAndFillNewDayEntry(context, element: element, comment: comment, date: date)
    }
    
    func clearData(_ context: NSManagedObjectContext, data: FetchedResults<DayDetail>) {
        data.forEach {
            context.delete($0)
            saveContext(context)
        }
    }
}

