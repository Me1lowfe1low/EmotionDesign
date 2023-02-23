// Created for EmotionDesign on 20.02.2023
//  HomeScreen.swift
//  EmotionDesign
//
// Using Swift 5.0
// Running on macOS 13.0
//
//   
// Unauthorised reproduction is prohibited, contact dmgordienko@gmail.com for details
// Could be used in educational purposes 

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .frame(height: 100)
                .overlay(
                    HStack(spacing: 20) {
                        Image("enjoyment")
                            .resizable()
                            .frame(width: 70, height: 70, alignment: .leading)
                            .padding()
                        VStack {
                            Text("Hello there!")
                                .font(.title2)
                                .bold()
                            Text("Welcome back! Can you share with me how you're feeling right now?")
                                .font(.caption)
                        }
                        .padding(.vertical)
                    }
                    
                )
                .shadow(radius: 15)
            
            RoundedRectangle(cornerRadius: 40)
                .fill(.white)
                .frame(height: 300)
                .overlay(
                    Text("This application was created with intention to help users to control and analyze their emotions. \n\n It contains a wide range of emotions that user could choose and review an infographycs in day slices. \n\n Finally one could review how all emotions they felt are accumulated in the colorfull graph. The less negative emotions were felt - the clearer would be the image.")
                        .font(.caption)
                        .bold()
                        .padding()
                )
                .shadow(radius: 15)
        }
        .padding()
    }
        
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
