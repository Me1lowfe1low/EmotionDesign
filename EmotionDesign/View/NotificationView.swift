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
    @EnvironmentObject var dataOrchestrator: DataOrchestrator
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \AppNotification.date, ascending: false)]) var notifications: FetchedResults<AppNotification>

    var body: some View {
        VStack {
            NavigationLink(destination: ScheduleView(recievedNotification: nil)
                .environment(\.managedObjectContext, moc)
                .environmentObject(dataOrchestrator)) {
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
            Divider()
            List {
                if notifications.isEmpty {
                    EmptyView()
                } else {
                    ForEach(notifications, id: \.id) { entry in
                        ZStack {
                            ScheduledNotification(recievedNotification: entry)
                            NavigationLink("Invisible link", destination: ScheduleView(recievedNotification: entry)
                                .environment(\.managedObjectContext, moc)
                                .environmentObject(dataOrchestrator))
                            .opacity(0.0)
                        }
                        .listRowBackground(Color(UIColor.secondarySystemBackground))
                        .padding()
                    }
                    .onDelete(perform: delete)
                }
            }
            .background(Color(UIColor.secondarySystemBackground))
            .listStyle(.plain)
        }
        .padding(.bottom, 10)
        .background(Color(UIColor.secondarySystemBackground))
        .scrollContentBackground(.hidden)
        .onAppear(perform: checkPermissions )
    }
    
    func checkPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                dataOrchestrator.logger.info("All set!")
            } else if let error = error {
                dataOrchestrator.logger.error("\(error.localizedDescription)")
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            dataOrchestrator.removeNotifications(notification: notifications[offset])
            dataOrchestrator.delete(notifications[offset])
        }
    }
}

/*struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NotificationView()
                .environment(\.managedObjectContext, CoreDataManipulator.preview.container.viewContext)
                .environmentObject(DataController.preview)
        }
    }
}*/
