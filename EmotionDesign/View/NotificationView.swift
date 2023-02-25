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
                NavigationLink(destination: ScheduleView(recievedNotification: nil)
                    .environment(\.managedObjectContext, moc)
                    .environmentObject(dataController)) {
                    Image(systemName: "plus")
                }
            }
            .padding()
           
            Spacer()
            Form {
                HStack {
                    Text("Notification")
                    Spacer()
                }
                .padding()
                if notifications.isEmpty {
                    EmptyView()
                } else {
                    List {
                        ForEach(notifications, id: \.id) { entry in
                            ZStack {
                                ScheduledNotification(recievedNotification: entry)
                                NavigationLink("Invisible link", destination: ScheduleView(recievedNotification: entry)
                                    .environment(\.managedObjectContext, moc)
                                    .environmentObject(dataController))
                                .opacity(0.0)
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            dataController.removeNotificationsFromTheCenter(moc, notification: notifications[offset])
            dataController.delete(moc, notification: notifications[offset])
        }
    }
}

struct Schedule_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NotificationView()
                .environment(\.managedObjectContext, DataController.preview.container.viewContext)
                .environmentObject(DataController.preview)
        }
    }
}
