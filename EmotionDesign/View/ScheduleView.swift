// Created for EmotionDesign on 21.02.2023
//  ScheduleView.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

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
            DatePicker(selection: $notificationDTO.time, in: Date.now..., displayedComponents: .hourAndMinute)
            {
                Text("")
            }
            .datePickerStyle(.wheel)
            HStack(spacing: 0) {
                Text("Repeat")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title3)
                NavigationLink(destination: DayList(days: $notificationDTO.period.days)) {
                    Text(notificationDTO.returnPeriod().capitalized)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
               
            }
            .padding()
            HStack(spacing: 0) {
                Text("Label: ")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title3)
                TextField("Alarm", text: $notificationDTO.title)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
            }
            .padding()
            Spacer()
            HStack {
                Spacer()
                Button(action: { saveNotification()
                    dismiss() }) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(height: 50 ,alignment: .center)
                            .shadow(radius: 5)
                            .padding()
                            .overlay(
                                Text("Save")
                                    .font(.title3)
                                    .bold()
                                    .fixedSize()
                                    .scaledToFit()
                            )
                        
                }
                .font(.title3)
                .frame(alignment: .topTrailing)
            }
            .padding()
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
