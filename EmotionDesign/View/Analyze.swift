// Created for EmotionDesign on 08.02.2023
//  Analyze.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import SwiftUI

struct Analyze: View {
    //@EnvironmentObject var userData : UserDetails
    
    @State private var currentDate: Date = Date()
    @State private var userData: UserDetails = UserDetails.userDetailsSample
    @State private var genEmotions: [GeneralEmotion] = GeneralEmotion.emotionSampleList
    
    var body: some View {
        VStack {
            Form {
                Section("Days picture") {
                    ForEach(userData.info, id: \.self ) { day in
                        LazyVGrid(columns: [GridItem(.flexible())]) {
                            HStack( alignment: .top) {
                                ZStack {
                                    ForEach(day.emotionList, id: \.self) { emotion in
                                        AnimatedCircle(emotion: genEmotions[emotion.parentId])
                                    }
                                }
                                .frame(width: 100, height: 100)
                                .padding()
                                Spacer()
                                VStack(alignment: .leading) {
                                    Section(header: Text(day.date, style: .date)) {
                                        
                                        Text("You felt: ")
                                        ForEach(day.commentList, id: \.self) { comment in
                                            if comment != "" {
                                                Text(comment)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
           
            Section("Whole picture")
            {
                ZStack {
                    ForEach(userData.info, id: \.self ) { day in
                        HStack {
                            ForEach(day.emotionList, id: \.self) { emotion in
                                AnimatedCircle(emotion: genEmotions[emotion.parentId])
                            }
                            
                        }
                        .padding()
                    }
                }
            }
            .padding()
        }
    }
}

struct Analyze_Previews: PreviewProvider {
    
    static var previews: some View {
        Analyze()
    }
}
