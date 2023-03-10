// Created for EmotionDesign on 22.02.2023
//  ScheduledNotification.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import SwiftUI

struct ScheduledNotification: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: FunctionLayer //DataController
   
    @StateObject var notification: AppNotification
    @State private var enabled: Bool
    
    init(recievedNotification: AppNotification) {
        _notification = StateObject(wrappedValue: recievedNotification)
        _enabled = State(initialValue: recievedNotification.wrappedEnabled)
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            Toggle(notification.wrappedDate.formatted(date: .omitted, time: .shortened),isOn: $enabled )
                .font(.largeTitle)
                .onChange(of: enabled ) { _ in
                    notification.enabled = enabled as NSNumber
//                    dataController.saveContext(moc)
//                    dataController.toggleNotifications(moc, data: notification)
                    dataController.saveContext()
                    dataController.toggleNotifications(data: notification)
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
