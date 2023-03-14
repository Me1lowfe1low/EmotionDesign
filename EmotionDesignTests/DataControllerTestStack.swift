// Created for EmotionDesign on 10.03.2023
//  DataControllerTestStack.swift
//  EmotionDesignTests
//
//
//    dmgordienko@gmail.com 2023


import CoreData
import Foundation
//import SwiftUI
//import OSLog

class DataControllerTestStack {
    
    static let shared = DataControllerTestStack()
    
    let container: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "EmotionDesign")
        let description = container.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType
        
        container.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("Core Data failed to load: \(error!.localizedDescription)")
            }
        }
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.automaticallyMergesChangesFromParent = true
        mainContext.persistentStoreCoordinator = container.persistentStoreCoordinator
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.parent = self.mainContext
    }
}
