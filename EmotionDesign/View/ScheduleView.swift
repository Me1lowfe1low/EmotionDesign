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
    @EnvironmentObject var dataOrchestrator: DataOrchestrator

    @State var notification: AppNotification?
    @State var notificationDTO: NotificationEntry
    
    init(recievedNotification: AppNotification?) {
        if let notificationItem = recievedNotification {
            _notification = State(initialValue: notificationItem)
            _notificationDTO = State(initialValue: NotificationEntry(title: notificationItem.wrappedTitle, date: notificationItem.wrappedDate, period: notificationItem.returnWeek() , enabled: notificationItem.wrappedEnabled) )
        } else {
            _notificationDTO = State(initialValue: NotificationEntry() )
        }
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()
            VStack {
                DatePicker(selection: $notificationDTO.date, in: Date.now..., displayedComponents: .hourAndMinute)
                {
                    Text("")
                }
                .datePickerStyle(.wheel)
                Divider()
                HStack(spacing: 0) {
                    Text("Repeat")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title3)
                    NavigationLink(destination: DayList(days: $notificationDTO.period.days)) {
                        Text(notificationDTO.returnPeriod().capitalized)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .buttonStyle(.plain)
                }
                .padding()
                Divider()
                HStack(spacing: 0) {
                    Text("Label: ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title3)
                    TextField("Alarm", text: $notificationDTO.title)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .multilineTextAlignment(.trailing)
                }
                .padding()
                Divider()
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { saveNotification()
                        dismiss() }) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(UIColor.secondarySystemBackground))
                                .frame(height: 50 ,alignment: .center)
                                .shadow(color: Color(UIColor.systemFill) ,radius: 5)
                                .padding()
                                .overlay(
                                    Text("Save")
                                        .textCase(.uppercase)
                                        .font(.title3)
                                        .bold()
                                        .fixedSize()
                                        .scaledToFit()
                                )
                            
                        }
                        .font(.title3)
                        .frame(alignment: .topTrailing)
                        .buttonStyle(.plain)
                }
                .padding()
                
            }
            .padding()
        }
        .navigationTitle("ADD NOTIFICATION")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func saveNotification() {
        dataOrchestrator.saveData(toAdd: notificationDTO, toEdit: notification)
        dismiss()
    }
}


/*struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScheduleView(recievedNotification: nil)
                .environment(\.managedObjectContext, CoreDataManipulator.preview.container.viewContext)
                .environmentObject(DataController.preview)
        }
    }
}*/
