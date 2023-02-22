// Created for EmotionDesign on 20.02.2023
//  NotificationView.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import SwiftUI
import UserNotifications

struct NotificationView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \AppNotification.date, ascending: false)]) var notifications: FetchedResults<AppNotification>
    
    @State var currentTIme: Date = Date()
    
    
    var body: some View {
        VStack {
            HStack {
                Button("Request permission") {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }
                Spacer()
                NavigationLink(destination: ScheduleView()
                    .environment(\.managedObjectContext, moc)
                    .environmentObject(dataController)) {
                    Image(systemName: "plus")
                }
            }
            .padding()
           
            Spacer()
            Text(Date(), style: .time)
                .font(.title)
                .bold()
            Form {
                HStack {
                    Text("Notification")
                    Spacer()
                }
                .padding()
                List {
                    ForEach(notifications, id: \.id) { entry in
                            alarmElement(notification: entry)
                    }
                    .onDelete(perform: delete)
                }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            dataController.delete(moc, notification: notifications[offset])
        }
    }
    
    func scheduleLocalNotification() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Schedule notification"
        content.subtitle = "What is your feelings right now?"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 15
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.removeAllPendingNotificationRequests()
        center.add(request)
        
        print("Notification scheduled")
    }
}

struct alarmElement: View {
    @State var notification: AppNotification
    @State private var enabled = true
   
    var body: some View {
        VStack(alignment: .trailing) {
            Toggle(notification.wrappedDate.formatted(date: .omitted, time: .shortened),isOn: $enabled)
                .font(.title3)
            HStack {
                Text(notification.wrappedTitle)
                    .font(.callout)
                Spacer()
                Text(notification.returnPeriod())
            }
        }
        .padding()
    }
}

struct Schedule_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NotificationView()
        }
    }
}
