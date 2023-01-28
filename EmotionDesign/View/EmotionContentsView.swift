//
//  EmotionContentsView.swift
//  EmotionDesign
//
//  Created by Дмитрий Гордиенко on 26.01.2023.
//

import SwiftUI

struct EmotionContentsView: View {
    let emotionList: [GeneralEmotion] = GeneralEmotion.emotionSampleList
    @State var choice: Int = -1
    
    var body: some View {
        VStack {
            //Toolbar with elements
            HStack(spacing: 0) {
                Group{
                        ForEach(emotionList.indices, id: \.self) { index in
                            Text(emotionList[index].name)
                                .font(.caption2)
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(Rectangle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [
                                        emotionList[index].color.getColor,
                                        emotionList[index].accentColor.getColor,
                                        (index + 1) < emotionList.count ? emotionList[index+1].color.getColor : emotionList[index].accentColor.getColor]),
                                                         startPoint: .leading,
                                                         endPoint: .trailing)
                                    ))
                                .gesture(
                                    TapGesture()
                                        .onEnded {
                                            choice = index
                                            print("You've just tapped # \(choice) button")
                                        }
                                )
                        }
                }
            }
            .mask(RoundedRectangle(cornerRadius: 40))
            .padding()
            
            Text("There sould be line with buttons")
            //View that will hold all choosen emotions. Each would have it's shape
            
            Divider()
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                if ( choice == -1 ) {
                    Spacer()
                } else
                {
                    ForEach(emotionList[choice].subEmotions) { emotion in
                        ZStack {
                            AnimatedCircle(emotion: emotionList[choice])
                            Circle()
                                .fill(LinearGradient(colors: [
                                    emotionList[choice].color.getColor,
                                    emotionList[choice].accentColor.getColor
                                ],
                                                     startPoint: .topLeading,
                                                     endPoint: .bottomTrailing))
                            Text(emotion.name)
                                .font(.caption2)
                                .frame(alignment: .center)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}
    
struct AnimatedCircle: View {
    var emotion: GeneralEmotion
    private let multiplier: [Int] = [-1,1]
    @State private var rotationAngle = 0.0
    
    var body: some View {
        ForEach(1...3, id: \.self) { _ in
            Circle()
                .offset(x: CGFloat.random(in: 0...30)*CGFloat(multiplier.randomElement() ?? 1), y: CGFloat.random(in: 0...30)*CGFloat(multiplier.randomElement() ?? 1))
                .fill(LinearGradient(colors: [
                    emotion.color.getColor,
                    emotion.accentColor.getColor],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .opacity(Double.random(in: 0.1...0.5))
                .rotationEffect(.degrees(rotationAngle))
                .onAppear {
                    withAnimation(
                        .linear(duration: 1)
                        .speed(0.1)
                        .repeatForever(autoreverses: false)
                    ){
                        rotationAngle = 360.0
                    }
                }
        }
    }
}

struct EmotionContentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmotionContentsView()
        }
    }
}
