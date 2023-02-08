// Created for EmotionDesign on 25.01.2023
//  EmotionShareView.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes

import SwiftUI

struct EmotionShareView: View {
    @EnvironmentObject var userData : UserDetails
    
    var body: some View {
        NavigationLink(destination: EmotionContentsView()
            .environmentObject(userData)
        ) {
            Image(systemName: "plus")
        }
    }
}

struct EmotionShareView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionShareView()
    }
}
