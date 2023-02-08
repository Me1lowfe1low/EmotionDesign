// Created for EmotionDesign on 05.02.2023
//  EmotionDetailsView.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import SwiftUI

struct EmotionDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userData: UserDetails
    
    @Binding var element: EmotionDTO
    @State var description: String = ""
    @State var initialDate: Date = Date()
    
    var body: some View {
        Form {
            Section(header: Text(element.emotion.name!)) {
                TextField("Description", text: $description)
                HStack {
                    Text(initialDate, style: .date)
                    Text(initialDate, style: .time)
                }
            }
            Text("Commit")
                .gesture(
                    TapGesture()
                        .onEnded {
                            processTheEntry()
                        }
                )
        }
    }
    
    func processTheEntry() {
        userData.processTheEntry(date: initialDate, comment: description, emotion: element.emotion)
        element.chosen = false
        dismiss()
    }
}

struct EmotionDetaisView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionDetailsView(element: .constant(EmotionDTO(emotion: Emotion.emotionSample , colour: .red, chosen: true )))
    }
}
