// Created for EmotionDesign on 28.01.2023
//  FireShape.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import SwiftUI

struct FireShape: View {
    var body: some View {
        LinearGradient(colors: [.yellow,.red], startPoint: .topLeading, endPoint: .bottomTrailing)
            .mask{
                Fire()
            }
    }
    
    struct Fire: InsettableShape {
        var insetAmount = 0.0
        
        func path(in rect: CGRect) -> Path {
            Path { path in
                let height = rect.height
                let width = rect.width
                let radius = min(height/4, width/4) - insetAmount
                let startAngle: Double = .pi * 11/6
                let endAngle: Double = .pi/2
                let startPointAngle = .pi*2 - startAngle
            
                path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: Angle(radians: startAngle), endAngle: Angle(radians: endAngle), clockwise: false)
                path.addCurve(
                    to: CGPoint(x: rect.midX - 0.75*radius, y: rect.midY - 1.25*radius),
                    control1: CGPoint(x: rect.minX + 0.25*radius, y: rect.midY + 0.75*radius),
                    control2: CGPoint(x: rect.midX - 0.75*radius, y: rect.midY - 0.75*radius))
                path.addQuadCurve(to: CGPoint(x: rect.midX - 0.5*radius, y: rect.midY - 0.5*radius), control: CGPoint(x: rect.midX - 0.55*radius, y: rect.midY - radius))
                path.addQuadCurve(
                    to: CGPoint(x: rect.midX - 0.5*radius, y: rect.midY - 2*radius),
                    control: CGPoint(x: rect.midX, y: rect.midY - radius ))
                path.addQuadCurve(
                    to: CGPoint(x: rect.midX + 0.5*radius, y: rect.midY ),
                    control: CGPoint(x: rect.midX + 0.5*radius , y: rect.midY - 1.5*radius ))
                path.addQuadCurve(
                    to: CGPoint(x: rect.midX + radius*cos(startPointAngle), y: rect.midY -  radius*sin(startPointAngle)),
                    control: CGPoint(x: rect.midX + 0.75*radius , y: rect.midY))
                path.closeSubpath()
            }
        }
        
        func inset(by amount: CGFloat) -> some InsettableShape {
            var fire = self
            fire.insetAmount += amount
            return fire
        }
    }
}

struct FireShape_Previews: PreviewProvider {
    static var previews: some View {
        FireShape()
    }
}
