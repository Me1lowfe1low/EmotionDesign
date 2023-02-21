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

    @State var notification: Alert = Alert()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Save") {
                    print("Saving data")
                    saveNotification()
                    dismiss()
                }
                .frame(width: .infinity, alignment: .topTrailing)
            }
            .padding()
            DatePicker(selection: $notification.time, in: ...Date.now, displayedComponents: .hourAndMinute)
            {
                Text("")
            }
            .datePickerStyle(.wheel)
            List {
                HStack(spacing: 0) {
                    Text("Repeat")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    NavigationLink(destination: dayList(notification: $notification)) {
                        Text(notification.returnPeriod().capitalized)
                    }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack {
                    Text("Label: ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Alarm", text: $notification.title)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .padding()
        .navigationTitle("Add notification")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    struct dayList: View {
        @Binding var notification: Alert
        
        var body: some View {
            List {
                ForEach(notification.period.days.indices, id: \.self) { dayIndex in
                    Button(action: {
                        notification.period.days[dayIndex].changeState()
                        print(notification.period)
                    }) {
                        HStack {
                            Text("Every \(notification.period.days[dayIndex].name)")
                            Spacer()
                            Image(systemName: notification.period.days[dayIndex].checked ? "checkmark" : "")
                        }
                    }
                }
            }
        }
    }
    
    func saveNotification() {
        dataController.saveData(moc, element: notification)
        dismiss()
    }
    
}

struct Alert: Identifiable {
    let id = UUID()
    var title: String = "Alert"
    var time: Date = Date()
    var period: Week = Week()
    var enabled: Bool = false

    
    func returnPeriod() -> String {
        var stringPeriod: String = "Never"
        guard self.period.repeatState() == .none else {
            guard self.period.repeatState()  == .all else {
                stringPeriod = ""
                period.days.forEach { day in
                    if day.checked == true {
                        stringPeriod += "\(day.shortName) "
                    }
                }
                return stringPeriod
            }
            return "Every day"
        }
        return stringPeriod
        
    }

}

struct Day: Identifiable, Hashable {
    var id: UUID = UUID()
    var shortName: WeekdaySchedule
    var name: String
    var checked: Bool = false
    
    mutating func changeState() {
        self.checked = !checked
    }

}

struct Week {
    var days: [Day] = []
    //var repeatState: chosenState = chosenState.none

    init() {
        days = WeekdaySchedule.allCases.map { Day(shortName: WeekdaySchedule(rawValue: $0.rawValue) ?? .mon, name: $0.name) }
    }
    
    func repeatState() -> ChosenState {
        var chosenState = ChosenState.few
        let daysChosen = days.filter { $0.checked == true }
        if daysChosen.count == days.count {
            chosenState = ChosenState.all
        } else if daysChosen.count == 0 {
            chosenState = ChosenState.none
        }
        return chosenState
    }
}

enum ChosenState: Int {
    case all
    case none
    case few
}

enum WeekdaySchedule: Int, CaseIterable, Hashable {
    case mon = 0
    case tue = 1
    case wed = 2
    case thu = 3
    case fri = 4
    case sat = 5
    case sun = 6
    
    var id: Int {
        return self.rawValue
    }
    
    var name: String {
        switch self {
            case .mon:
                return "Monday"
            case .tue:
                return "Tuesday"
            case .wed:
                return "Wednesday"
            case .thu:
                return "Thursday"
            case .fri:
                return "Friday"
            case .sat:
                return "Saturday"
            case .sun:
                return "Sunday"
            default:
                return "None"
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScheduleView()
        }
    }
}
