// Created for EmotionDesign on 20.02.2023
//  NotificationView.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import SwiftUI
import UserNotifications

struct NotificationView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \AppNotification.date, ascending: false)]) var notifications: FetchedResults<AppNotification>
    
    @State var currentTIme: Date = Date()
    
    var body: some View {
        VStack {
            NavigationLink(destination: ScheduleView(recievedNotification: nil)
                .environment(\.managedObjectContext, moc)
                .environmentObject(dataController)) {
                    HStack {
                        Text( "Notification")
                            .textCase(.uppercase)
                            .padding()
                        Spacer()
                        Image(systemName: "plus" )
                            .padding()
                    }
                    .bold()
                    .font(.title2)
                    .padding()
                }
                .buttonStyle(.plain)
            List {
                if notifications.isEmpty {
                    EmptyView()
                } else {
                    ForEach(notifications, id: \.id) { entry in
                        ZStack {
                            ScheduledNotification(recievedNotification: entry)
                            NavigationLink("Invisible link", destination: ScheduleView(recievedNotification: entry)
                                .environment(\.managedObjectContext, moc)
                                .environmentObject(dataController))
                            .opacity(0.0)
                        }
                        .padding()
                    }
                    .onDelete(perform: delete)
                }
            }
            .listStyle(.plain)
        }
        .background(Color(UIColor.secondarySystemBackground))
        .onAppear(perform: checkPermissions )
    }
    
    func checkPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                dataController.logger.info("All set!")
            } else if let error = error {
                dataController.logger.error("\(error.localizedDescription)")
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

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NotificationView()
                .environment(\.managedObjectContext, DataController.preview.container.viewContext)
                .environmentObject(DataController.preview)
        }
    }
}
