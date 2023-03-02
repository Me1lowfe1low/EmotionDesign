// Created for EmotionDesign on 20.02.2023
//  HomeScreen.swift
//  EmotionDesign
//
// COPYRIGHT dmgordienko@gmail.com 2023
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 25)
                .fill(Color(UIColor.secondarySystemBackground))
                    .frame(height: 100)
                    .overlay(
                        HStack(spacing: 20) {
                            Image("enjoyment")
                                .resizable()
                                .frame(width: 70, height: 70, alignment: .leading)
                                .padding()
                            VStack {
                                Text("Hello there!")
                                    .font(.largeTitle)
                                    .bold()
                                Text("Welcome back")
                                    .font(.title2)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.vertical)
                        }
                        
                    )
                    .padding()
                    .shadow(color: Color(UIColor.systemFill) ,radius: 5)

        
            RoundedRectangle(cornerRadius: 40)
                .fill(Color(UIColor.secondarySystemBackground))
                .overlay(
                    Text("This application was created with intention to help users to control and analyze their emotions. \n\n It contains a wide range of emotions that user could choose and review an infographycs in day slices. \n\n Finally one could review how all emotions they felt are accumulated in the colorfull graph.")
                        .font(.title3)
                        .padding(.horizontal, 40)
                        .multilineTextAlignment(.leading)
                )
                .padding()
                .shadow(color: Color(UIColor.systemFill) ,radius: 5)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
    }
        
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
