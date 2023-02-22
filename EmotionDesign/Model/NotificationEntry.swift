// Created for EmotionDesign on 22.02.2023
//  NotificationEntry.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import Foundation

struct NotificationEntry: Identifiable {
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
        }
    }
}
