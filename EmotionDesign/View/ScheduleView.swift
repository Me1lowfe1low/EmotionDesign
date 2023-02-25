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

    @State var notification: AppNotification?
    @State var notificationDTO: NotificationEntry
    
    init(recievedNotification: AppNotification?) {
        if let notificationItem = recievedNotification {
            _notification = State(initialValue: notificationItem)
            _notificationDTO = State(initialValue: NotificationEntry(title: notificationItem.wrappedTitle, time: notificationItem.wrappedDate, period: notificationItem.returnWeek() , enabled: notificationItem.wrappedEnabled) )
        } else {
            _notificationDTO = State(initialValue: NotificationEntry() )
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Save") {
                    saveNotification()
                    dismiss()
                }
                .frame(alignment: .topTrailing)
            }
            .padding()
            DatePicker(selection: $notificationDTO.time, in: Date.now..., displayedComponents: .hourAndMinute)
            {
                Text("")
            }
            .datePickerStyle(.wheel)
            List {
                HStack(spacing: 0) {
                    Text("Repeat")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    NavigationLink(destination: DayList(days: $notificationDTO.period.days)) {
                        Text(notificationDTO.returnPeriod().capitalized)
                    }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack {
                    Text("Label: ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Alarm", text: $notificationDTO.title)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .padding()
        .navigationTitle("Add notification")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func saveNotification() {
        dataController.saveData(moc, toAdd: notificationDTO, toEdit: notification)
        dismiss()
    }
}


struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScheduleView(recievedNotification: nil)
                .environment(\.managedObjectContext, DataController.preview.container.viewContext)
                .environmentObject(DataController.preview)
        }
    }
}
