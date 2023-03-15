// Created for EmotionDesign on 22.02.2023
//  ScheduledNotification.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import SwiftUI

struct ScheduledNotification: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataOrchestrator: DataOrchestrator
   
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
                        dataOrchestrator.changeNotificationState(notification: notification, to: enabled)
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
