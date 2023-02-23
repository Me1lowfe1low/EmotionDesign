// Created for EmotionDesign on 18.02.2023
//  InfoView.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import SwiftUI

struct InfoView: View {
    private let emotionList: [InitialEmotion] = Bundle.main.decode([InitialEmotion].self, from: "EmotionInitialList.json")
    
    @State var emotionsView = PostitionListDTO()
    @State private var offset = CGSize.zero
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Emotion description")
                .font(.title)
                .textCase(.uppercase)
                .padding()
            HStack {
                ZStack {
                    ForEach($emotionsView.positionList, id: \.id) { $emotion in
                        EmotionView(position: $emotion)
                            .frame(alignment: emotion.position.alignment)
                            .animation(.easeInOut, value: 2)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        offset = CGSize(width: gesture.translation.width,  height: 0)
                                    }
                                    .onEnded { _ in
                                        if offset.width < 0 {
                                            offset = CGSize.zero
                                            emotionsView.moveLeft()
                                        } else {
                                            offset = CGSize.zero
                                            emotionsView.moveRight()
                                        }
                                    }
                            )
                        
                    }
                }
            }
            Text(emotionList[emotionsView.positionList.last!.elementId].name)
                .font(.title2)
                .foregroundColor(emotionList[emotionsView.positionList.last!.elementId].getColor())
                .bold()
                .shadow(radius: 0.8)
                .textCase(.uppercase)
                .padding()
            Text(emotionList[emotionsView.positionList.last!.elementId].description)
                .font(.callout)
                .padding()
            Spacer()
        }
        .padding()
    }
    
    struct EmotionView: View {
        @Binding var position: PositionDTO
        
        private let emotionList: [InitialEmotion] = Bundle.main.decode([InitialEmotion].self, from: "EmotionInitialList.json")
        
        var body: some View {
            HStack {
                if position.position == .right {
                    Spacer()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: position.position == .center ? 40 : 20)
                        .fill(.white)
                        .frame(width: position.position == .center ? 175 : 90, height: position.position == .center ? 175 : 90)
                        .shadow(radius: 25)
                    Image(emotionList[position.elementId].icon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: position.position == .center ? 40 : 20)
                        )
                        .frame(width: position.position == .center ? 175 : 90, height: position.position == .center ? 175 : 90)
                }
                if position.position == .left {
                    Spacer()
                }
            }
            .padding()
        }
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

struct PositionDTO: Identifiable {
    var id: UUID = UUID()
    var elementId: Int
    var position: Position
}

struct PostitionListDTO: Identifiable {
    var id: UUID = UUID()
    var positionList: [PositionDTO] =
    [PositionDTO(elementId: 1, position: .left),PositionDTO(elementId: 3, position: .right),PositionDTO(elementId: 2, position: .center)]
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


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
