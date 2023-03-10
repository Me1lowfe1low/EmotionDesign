// Created for EmotionDesign on 05.02.2023
//  EmotionDetailsView.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import SwiftUI

struct EmotionDetailsView: View {
    @EnvironmentObject var dataController: FunctionLayer//DataController
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) private var dismiss
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DayDetail.date, ascending: false)]) var userDataSet: FetchedResults<DayDetail>
    
    @Binding var element: EmotionDTO
    @State var description: String = ""
    @State var initialDate: Date = Date()
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(colors: dataController.emotionJsonList[element.emotion.parent].returnColors(),
                 startPoint: .topLeading,
                 endPoint: .bottomTrailing)
                .mask(RoundedRectangle(cornerRadius: 40)
                    .padding())
                .opacity(0.75)
                Image(element.emotion.icon)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .blendMode(.sourceAtop)
            }
            Form {
                Section(header: Text(element.emotion.name)
                    .bold()
                    .textCase(.uppercase)
                    .foregroundColor(dataController.emotionJsonList[element.emotion.parent].getColor())
                ) {
                    TextField("Description", text: $description)
                        .textCase(.uppercase)
                    HStack {
                        Text(initialDate, style: .date)
                        Text(initialDate, style: .time)
                    }
                }
            }
            .formStyle(.columns)
            .padding()
            Button( action: processTheEntry )
            {
                    RoundedRectangle(cornerRadius: 20)
                    .fill(Color(UIColor.secondarySystemBackground))
                        .frame(height: 50 ,alignment: .center)
                        .shadow(color: Color(UIColor.systemFill) ,radius: 5)
                        .padding()
                        .overlay(
                            Text("Save")
                                .font(.caption2)
                                .textCase(.uppercase)
                                .bold()
                                .fixedSize()
                                .scaledToFit()
                        )
            }
            .buttonStyle(.plain)
        }
        .background(Color(UIColor.secondarySystemBackground))
        .navigationTitle("CHOSE EMOTION")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func processTheEntry() {
//        dataController.saveData(moc, data: userDataSet, element: element, comment: description, date: initialDate)
        dataController.saveData(data: userDataSet, element: element, comment: description, date: initialDate)
        element.chosen = false
        dismiss()
    }
}

/*struct EmotionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmotionDetailsView(element: .constant(EmotionDTO(emotion: SubEmotion.emotionSample1, color: .red))).preferredColorScheme(.dark)
                .environmentObject(DataController.preview)
                .environment(\.managedObjectContext, DataController.preview.container.viewContext)
        }
    }
}*/
