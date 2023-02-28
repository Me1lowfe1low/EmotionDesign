// Created for EmotionDesign on 25.02.2023
//  PostitionListDTO.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import Foundation
import SwiftUI


struct PostitionListDTO: Identifiable {
    var id: UUID = UUID()
    var positionList: [PositionDTO] = [
        PositionDTO(elementId: 1, position: .left),
        PositionDTO(elementId: 3, position: .right),
        PositionDTO(elementId: 2, position: .center)
    ]
    private let emotionList: [InitialEmotion] = Bundle.main.decode([InitialEmotion].self, from: "EmotionInitialList.json")
    
    
    mutating func moveLeft() {
        for ind in 0..<positionList.count {
            if positionList[ind].elementId != 0 {  positionList[ind].elementId -= 1
            } else {
                positionList[ind].elementId = emotionList.count - 1
            }
        }
    }
    
    mutating func moveRight() {
        for ind in 0..<positionList.count {
            if positionList[ind].elementId != emotionList.count - 1 {
                positionList[ind].elementId += 1
            } else {
                positionList[ind].elementId = 0
            }
        }
    }
    
    func printPositions() {
        let tempPositionList = positionList.map { $0.elementId }
        print(tempPositionList)
    }
}

struct PositionDTO: Identifiable {
    var id: UUID = UUID()
    var elementId: Int
    var position: Position
    
    func getSize() -> CGFloat {
        self.position == .center ? 175 : 90
    }
    
    func getRadius() -> CGFloat {
        self.position == .center ? 40 : 20
    }
}


enum Position: String {
    case left
    case center
    case right
    
    public var alignment: Alignment {
        var alignTo: Alignment
        switch self {
            case .left:
                alignTo = Alignment.leading
            case .right:
                alignTo = Alignment.trailing
            default:
                alignTo = Alignment.center
        }
        return alignTo
    }
}


