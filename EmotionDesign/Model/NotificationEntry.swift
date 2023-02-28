// Created for EmotionDesign on 22.02.2023
//  NotificationEntry.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

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
    case mon = 2
    case tue = 3
    case wed = 4
    case thu = 5
    case fri = 6
    case sat = 7
    case sun = 1
    
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
