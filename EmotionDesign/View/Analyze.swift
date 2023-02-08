// Created for EmotionDesign on 08.02.2023
//  Analyze.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import SwiftUI

struct Analyze: View {
    var body: some View {
        Form {
            Section("Day") {
                HStack{
                    Text("Pie")
                    Text("Graph")
                }
            }
            Section("Week") {
                Text("Week calendar")
            }
            Section("Year") {
                Text("Year calendar")
                Text("Graph")
            }
        }
    }
}

struct Analyze_Previews: PreviewProvider {
    static var previews: some View {
        Analyze()
    }
}
