// Created for EmotionDesign on 21.02.2023
//  ScheduleView.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import SwiftUI

struct ScheduleView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var dataController: DataController

    
    @State var notification: NotificationEntry = NotificationEntry()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Save") {
                    saveNotification()
                    dismiss()
                }
                .frame(width: .infinity, alignment: .topTrailing)
            }
            .padding()
            DatePicker(selection: $notification.time, in: ...Date.now, displayedComponents: .hourAndMinute)
            {
                Text("")
            }
            .datePickerStyle(.wheel)
            List {
                HStack(spacing: 0) {
                    Text("Repeat")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    NavigationLink(destination: DayList(scheme: $notification)) {
                        Text(notification.returnPeriod().capitalized)
                    }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack {
                    Text("Label: ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Alarm", text: $notification.title)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .padding()
        .navigationTitle("Add notification")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func saveNotification() {
        dataController.saveData(moc, element: notification)
        dismiss()
    }
    
}


struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScheduleView()
        }
    }
}
