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
    
}
