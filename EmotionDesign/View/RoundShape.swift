//
//  RoundShape.swift
//  EmotionDesign
//
//  Created by Дмитрий Гордиенко on 25.01.2023.
//

import SwiftUI

struct RoundShape: View {
    @State private var radius: CGFloat = 50
    let emotionList: [Emotion] = Emotion.emotionSampleList
    
    var body: some View {
        ZStack {
            Round()
                .opacity(0.1)
                .padding()
            RoundedRectangle(cornerRadius: 2)
            .fill(LinearGradient(colors: [Color.indigo, Color.purple], startPoint: .top, endPoint: .bottom))
            .opacity(0.042)
            ForEach(emotionList.indices, id: \.self) { index in
                RoundedShape(segments: 6, id: index)
                    .fill(LinearGradient(colors: [emotionList[index].color.getColor, emotionList[index].accentColor.getColor ], startPoint: .top, endPoint: .bottom))
                RoundedShape(segments: 6, id: index)
                    .stroke(.white, lineWidth: 5)
            }
        }
    }
    struct Round: Shape {
        func path(in rect: CGRect) -> Path {
            Path { path in
                let height = rect.height
                let width = rect.width
                let radius = min(height/4, width/4)
                
                path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
            }
        }
    }
    
    struct RoundedShape: Shape {
        let segments: Int
        let id: Int
        private let startAngle: Double = 1.5 * Double.pi
        private let outerRadiusCoeff: Double = 1.5
        
        func path(in rect: CGRect) -> Path {
            Path { path in
                let height = rect.height
                let width = rect.width
                let radius = min(height/4, width/4)
                let outerRadius = outerRadiusCoeff*radius
                let segmentAngle: Double = (2*Double.pi)/Double(segments)
                let rotationAngle: Double = startAngle + Double(id) * segmentAngle
                let currentAngle: Double = rotationAngle + segmentAngle
                
                let startPointX1 = rect.midX + outerRadius*cos(rotationAngle)
                let startPointY1 = rect.midY + outerRadius*sin(rotationAngle)
                let startPointX2 = rect.midX + radius*cos(rotationAngle)
                let startPointY2 = rect.midY + radius*sin(rotationAngle)
                let startPointX3 = rect.midX + outerRadius*cos(.pi*2 - rotationAngle - segmentAngle)
                let startPointY3 = rect.midY - outerRadius*sin(.pi*2 - rotationAngle - segmentAngle)
                
                path.move(to: CGPoint(x: startPointX1, y: startPointY1 ))
                path.addLine(to: CGPoint(x: startPointX2, y: startPointY2 ))
                path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: Angle(radians: rotationAngle), endAngle: Angle(radians: currentAngle), clockwise: false)
                path.addLine(to: CGPoint(x: startPointX3, y: startPointY3))
                path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: outerRadius, startAngle: Angle(radians: currentAngle), endAngle: Angle(radians: rotationAngle), clockwise: true)
                path.closeSubpath()
            }
        }
    }
}

struct RoundShape_Previews: PreviewProvider {
    static var previews: some View {
        RoundShape()
    }
}
