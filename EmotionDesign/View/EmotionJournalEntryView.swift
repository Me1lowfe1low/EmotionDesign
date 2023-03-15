// Created for EmotionDesign on 28.02.2023
//  EmotionJournalEntryView.swift
//  EmotionDesign
//
//
//    dmgordienko@gmail.com 2023

import SwiftUI

struct EmotionJournalEntryView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataOrchestrator: DataOrchestrator
    @State var day: DayDetail
    @Binding var filter: ChartFilter
    
    var body: some View {
        if filter.contains(day.wrappedDate) {
            ForEach(day.emotions, id: \.self) { emotion in
                HStack(spacing: 10) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(UIColor.secondarySystemBackground))
                            .frame(width: 90, height: 90, alignment: .leading)
                            .shadow(color: Color(UIColor.systemFill) ,radius: 5)
                        Image(dataOrchestrator.emotionJsonList[Int(emotion.parent)].findEmotionIcon(emotion.name!))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius:  20))
                            .frame(width: 90, height: 90)
                    }
                    VStack(alignment: .leading) {
                        Text(emotion.name!)
                            .font(.caption)
                            .foregroundColor(dataOrchestrator.emotionJsonList[Int(emotion.parent)].getColor())
                            .textCase(.uppercase)
                            .fixedSize()
                            .bold()
                        Text(emotion.comment!)
                            .font(.caption)
                    }
                    Spacer()
                    Text(day.getDate())
                        .font(.caption2)
                        .fixedSize()
                }
                .padding(.horizontal)
            }
        }
    }
}

