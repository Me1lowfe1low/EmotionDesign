// Created for EmotionDesign on 07.02.2023
//  UserDetails.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import Foundation

class UserDetails: ObservableObject {
    @Published var info = [UserDetail]()
    
    init() {
        
    }
    
    init(info: [UserDetail]) {
        self.info = info
    }
    
    func getSortedList() {
        self.info = info.sorted()
    }
    
    func addNewEntry(_ emotion: Emotion) {
        if checkCurrentDate() {
            //print("Date is current")
            guard self.info.last != nil  else {
                return
            }
            //print("Appending new data...")
            info[info.endIndex-1].emotionList.append(emotion)
            info[info.endIndex-1].commentList.append("")
        } else {
            //print("adding new date to the user vault")
            let newEntry = UserDetail(date: Date(), emotionList: [emotion], commentList: [""] )
            //print(newEntry)
            info.append(newEntry)
        }
    }
    
    func addNewEntry(_ emotion: Emotion, comment: String) {
        if checkCurrentDate() {
            //print("Date is current")
            guard self.info.last != nil  else {
                return
            }
            //print("Appending new data...")
            info[info.endIndex-1].emotionList.append(emotion)
            info[info.endIndex-1].commentList.append(comment)
            
        } else {
            //print("adding new date to the user vault")
            let newEntry = UserDetail(date: Date(), emotionList: [emotion], commentList: [comment] )
            //print(newEntry)
            info.append(newEntry)
        }
    }
    
    func processTheEntry(date: Date, comment: String, emotion: Emotion) {
        if findExactDate(date) {
            let index = getExactDate(date)
            info[index].commentList.append(comment)
            info[index].emotionList.append(emotion)
        }
        else {
            addNewEntry(emotion, comment: comment)
        }
        print(info)
    }
    
    func addEmotionToList(_ emotion: Emotion) {
        guard var lastElement = self.info.last  else {
            let newEntry = UserDetail(date: Date(), emotionList: [emotion], commentList: [""] )
            info.append(newEntry)
            return
        }
        lastElement.emotionList.append(emotion)
    }
    
    func checkCurrentDate() -> Bool {
        guard let lastElement = self.info.last  else {
            return false
        }
        return Calendar.current.isDate( lastElement.date, equalTo: Date(), toGranularity: .day )
    }
    
    func findExactDate(_ exactDate: Date) -> Bool {
        var flag = false
        guard self.info.last != nil else {
            return false
        }
        info.forEach { element in
            flag = flag || Calendar.current.isDate( element.date, equalTo: exactDate, toGranularity: .day )
        }
        return flag
    }
    
    func getExactDate(_ exactDate: Date) -> Int {
        var requestedIndex = -1
        guard self.info.last != nil else {
            return requestedIndex
        }
        for (index, item) in info.enumerated() {
            if Calendar.current.isDate( item.date, equalTo: exactDate, toGranularity: .day ) {
                requestedIndex = index
            }
        }
        return requestedIndex
    }
    
    func deleteAllButLast() {
        if let last = info.last {
            info = [last]
        }
    }
    
    func changeDescription(_ date: Date, comment: String) {
        let dateIndex = getExactDate(date)
        let emotionIndex = info[dateIndex].commentList.count - 1
        print(dateIndex)
        print(emotionIndex)
        info[dateIndex].commentList[emotionIndex] = comment
        print(info)
    }
    
    /*
     func reduceData(_ date: Date) -> [PiePower] {
     var piePower: [PiePower] = []
     let dateIndex = getExactDate(date)
     let mappedItems = info[dateIndex].emotionList.map { ($0, 1) }
     let counts = Dictionary(mappedItems, uniquingKeysWith: +)
     counts.forEach { element in
     let temp = PiePower(name: element.key.name!, power: element.value, colorId: element.key.parentId  )
     piePower.append(temp)
     }
     return piePower
     }
     */
    
#if DEBUG
    static let emotionList0: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 0),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 1),
        Emotion(name: "emotion#3", description: "Emotion description for the emotion#3", parentId: 2),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 1),
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 0),
        Emotion(name: "emotion#6", description: "Emotion description for the emotion#6", parentId: 1),
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 0),
        Emotion(name: "emotion#8", description: "Emotion description for the emotion#8", parentId: 0),
        Emotion(name: "emotion#9", description: "Emotion description for the emotion#9", parentId: 2),
    ]
    static let emotionList1: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 1),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 0),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 0),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 2),
    ]
    static let emotionList2: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 1),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 2),
    ]
    static let emotionList3: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 0),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 1),
        Emotion(name: "emotion#3", description: "Emotion description for the emotion#3", parentId: 3),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 1),
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 3),
        Emotion(name: "emotion#6", description: "Emotion description for the emotion#6", parentId: 1),
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 4),
        Emotion(name: "emotion#8", description: "Emotion description for the emotion#8", parentId: 0),
        Emotion(name: "emotion#9", description: "Emotion description for the emotion#9", parentId: 5),
    ]
    static let emotionList4: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 1),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 1),
        Emotion(name: "emotion#3", description: "Emotion description for the emotion#3", parentId: 5),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 1),
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 5),
        Emotion(name: "emotion#6", description: "Emotion description for the emotion#6", parentId: 3),
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 3),
        Emotion(name: "emotion#8", description: "Emotion description for the emotion#8", parentId: 0),
        Emotion(name: "emotion#9", description: "Emotion description for the emotion#9", parentId: 2),
    ]
    static let emotionList5: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 0),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 1),
        Emotion(name: "emotion#3", description: "Emotion description for the emotion#3", parentId: 5),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 5),
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 0),
        Emotion(name: "emotion#6", description: "Emotion description for the emotion#6", parentId: 2),
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 3),
        Emotion(name: "emotion#8", description: "Emotion description for the emotion#8", parentId: 0),
        Emotion(name: "emotion#9", description: "Emotion description for the emotion#9", parentId: 2),
    ]
    static let emotionList6: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 1),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 4),
        Emotion(name: "emotion#3", description: "Emotion description for the emotion#3", parentId: 3),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 3),
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 3),
        Emotion(name: "emotion#6", description: "Emotion description for the emotion#6", parentId: 1),
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 5),
        Emotion(name: "emotion#8", description: "Emotion description for the emotion#8", parentId: 0),
        Emotion(name: "emotion#9", description: "Emotion description for the emotion#9", parentId: 2),
    ]
    static let emotionList7: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 3),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 4),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 0),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 2),
    ]
    static let emotionList8: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 3),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 3),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 4),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 4),
    ]
    static let emotionList9: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 4),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 5),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 5),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 2),
    ]
    static let emotionList10: [Emotion] = [
        Emotion(name: "emotion#1", description: "Emotion description for the emotion#1", parentId: 5),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 5),
        Emotion(name: "emotion#2", description: "Emotion description for the emotion#2", parentId: 5),
        Emotion(name: "emotion#4", description: "Emotion description for the emotion#4", parentId: 4),
    ]
    static let userDetail0: UserDetail =
    UserDetail(date: Calendar.current.date(byAdding: .day, value: -10, to: Date())!, emotionList: emotionList0, commentList: ["","","","","","","","",""])
    static let userDetail1: UserDetail =
        UserDetail(date: Calendar.current.date(byAdding: .day, value: -9, to: Date())!, emotionList: emotionList1, commentList: ["","","",""])
    static let userDetail2: UserDetail =
        UserDetail(date: Calendar.current.date(byAdding: .day, value: -8, to: Date())!, emotionList: emotionList2, commentList: ["",""])
    static let userDetail3: UserDetail =
    UserDetail(date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, emotionList: emotionList3, commentList: ["","","","","","","","",""])
    static let userDetail4: UserDetail =
    UserDetail(date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, emotionList: emotionList4, commentList: ["","","","","","","","",""])
    static let userDetail5: UserDetail =
    UserDetail(date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, emotionList: emotionList5, commentList: ["","","","","","","","",""])
    static let userDetail6: UserDetail =
    UserDetail(date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, emotionList: emotionList6, commentList: ["","","","","","","","",""])
    static let userDetail7: UserDetail =
        UserDetail(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, emotionList: emotionList7, commentList: ["","","",""])
    static let userDetail8: UserDetail =
        UserDetail(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, emotionList: emotionList8, commentList: ["","","",""])
    static let userDetail9: UserDetail =
        UserDetail(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, emotionList: emotionList9, commentList: ["","","",""])
    static let userDetail10: UserDetail =
        UserDetail(date: Date(), emotionList: emotionList10, commentList: ["","","",""])

    
    static let userDataSet: [UserDetail] = [
        UserDetails.userDetail0,
        UserDetails.userDetail1,
        UserDetails.userDetail2,
        UserDetails.userDetail3,
        UserDetails.userDetail4,
        UserDetails.userDetail5,
        UserDetails.userDetail6,
        UserDetails.userDetail7,
        UserDetails.userDetail8,
        UserDetails.userDetail9,
        UserDetails.userDetail10,
    ]
    
    static let userDetailsSample: UserDetails = UserDetails(info: UserDetails.userDataSet )
  
    
#endif
}



