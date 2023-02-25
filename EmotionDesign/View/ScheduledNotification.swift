// Created for EmotionDesign on 22.02.2023
//  ScheduledNotification.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import SwiftUI

struct ScheduledNotification: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
   
    @StateObject var notification: AppNotification
    @State private var enabled: Bool
    
    init(recievedNotification: AppNotification) {
        _notification = StateObject(wrappedValue: recievedNotification)
        _enabled = State(initialValue: recievedNotification.wrappedEnabled)
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            Toggle(notification.wrappedDate.formatted(date: .omitted, time: .shortened),isOn: $enabled )
                .font(.title3)
                .onChange(of: enabled ) { _ in
                    notification.enabled = enabled as NSNumber
                    dataController.saveContext(moc)
                    dataController.toggleNotifications(moc, data: notification)
                }
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
