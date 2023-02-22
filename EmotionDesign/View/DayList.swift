// Created for EmotionDesign on 22.02.2023
//  DayList.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import SwiftUI

struct DayList: View {
    @Binding var scheme: NotificationEntry
    
    var body: some View {
        List {
            ForEach(scheme.period.days.indices, id: \.self) { dayIndex in
                Button(action: {
                    scheme.period.days[dayIndex].changeState()
                    print(scheme.period)
                }) {
                    HStack {
                        Text("Every \(scheme.period.days[dayIndex].name)")
                        Spacer()
                        Image(systemName: scheme.period.days[dayIndex].checked ? "checkmark" : "")
                    }
                }
            }
        }
    }
}

struct DayList_Previews: PreviewProvider {
    static var previews: some View {
        DayList(scheme: .constant(NotificationEntry()))
    }
}
