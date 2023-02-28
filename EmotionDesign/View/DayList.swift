// Created for EmotionDesign on 22.02.2023
//  DayList.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import SwiftUI

struct DayList: View {
    @Binding var days: [Day]
    
    var body: some View {
        List {
            ForEach(days.indices, id: \.self) { dayIndex in
                Button(action: {
                    days[dayIndex].changeState()
                }) {
                    HStack {
                        Text("Every \(days[dayIndex].name)")
                        Spacer()
                        Image(systemName: "checkmark")
                            .opacity(days[dayIndex].checked ? 1.0 : 0.0)
                    }
                }
            }
        }
    }
}

struct DayList_Previews: PreviewProvider {
    static var previews: some View {
        DayList(days: .constant(NotificationEntry().period.days))
    }
}
