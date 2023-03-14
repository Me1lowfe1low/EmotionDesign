// Created for EmotionDesign on 10.03.2023
//  EmotionDesignTests.swift
//  EmotionDesignTests
//
//
//    dmgordienko@gmail.com 2023

import XCTest
import CoreData
@testable import EmotionDesign

final class EmotionDesignTests: XCTestCase {

    var dataStorage: DataControllerTestStack!
    var sut: FunctionLayer!
    var dataControllerMock: DataControllerMock!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        dataStorage = DataControllerTestStack()
        dataControllerMock = DataControllerMock()
        dataControllerMock.mainContextStub = dataStorage.backgroundContext
        sut = FunctionLayer(dataController: dataControllerMock)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        //...
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // TODO: move to sepatate file
    func testChangeChosenStateTrue() throws {
        var emotionDTO = EmotionDTO.init(emotion: SubEmotion(), color: .red)
        
        emotionDTO.changeChosenState(to: true)
        
        XCTAssertTrue(emotionDTO.chosen)
    }
    
    // TODO: move to sepatate file
    func testChangeChosenStateFalse() throws {
        var emotionDTO = EmotionDTO.init(emotion: SubEmotion(), color: .red)
        
        emotionDTO.changeChosenState(to: false)
        
        XCTAssertFalse(emotionDTO.chosen)
    }
    
//    func testFetchDaysDetails() throws {
//        var days = try XCTUnwrap(sut.fetchDaysDetails())
//        XCTAssertTrue(days.isEmpty)
//
//        let day = DayDetail(context: sut.mainContext)
//        day.id = UUID()
//        day.comment = "test day data"
//        day.date = Date()
//        sut.saveContext()
//
//        let emotion = Emotion(context: sut.mainContext)
//        emotion.id = UUID()
//        emotion.name = "Joy"
//        emotion.parent = 2
//        emotion.comment = "test emotion data"
//        emotion.timestamp = Date()
//        emotion.day = day
//        sut.saveContext()
//
//        days = sut.fetchDaysDetails()!
//        XCTAssertFalse(days.isEmpty)
//    }
    
}
