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
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DayDetail.date, ascending: false)]) var userDataSet: FetchedResults<DayDetail>

    @Binding var element: EmotionDTO
    @State var description: String = ""
    @State var initialDate: Date = Date()
    
    var body: some View {
        Form {
            Section(header: Text(element.emotion.name)) {
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
        dataController.saveData(moc, data: userDataSet, element: element, comment: description, date: initialDate)
        element.chosen = false
        dismiss()
    }
}

struct EmotionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionDetailsView(element: .constant(EmotionDTO(emotion: SubEmotion.emotionSample, color: .red)))
            .environmentObject(DataController.preview)
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
    }
}
