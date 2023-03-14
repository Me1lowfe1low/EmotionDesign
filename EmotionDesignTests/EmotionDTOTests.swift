// Created for EmotionDesign on 13.03.2023
//  EmotionDTOTests.swift
//  EmotionDesignTests
//
//
//    dmgordienko@gmail.com 2023


import XCTest
import CoreData
@testable import EmotionDesign

final class EmotionDTOTests: XCTestCase {
    var emotionDTOMock: EmotionDTO!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        emotionDTOMock = EmotionDTO.init(emotion: SubEmotion(), color: .red)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        //...
        emotionDTOMock = nil
    }

    func testChangeChosenStateTrue() throws {
        emotionDTOMock.changeChosenState(to: true)
        
        XCTAssertTrue(emotionDTOMock.chosen)
    }
    
    func testChangeChosenStateFalse() throws {
        emotionDTOMock.changeChosenState(to: false)
        
        XCTAssertFalse(emotionDTOMock.chosen)
    }
}
