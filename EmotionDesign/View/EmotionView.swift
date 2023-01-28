//
//  EmotionView.swift
//  EmotionDesign
//
//  Created by Дмитрий Гордиенко on 25.01.2023.
//

import SwiftUI

struct EmotionView: View {
    @State var emotion: GeneralEmotion = GeneralEmotion.emotionSample
    
    var body: some View {
        VStack {
            Text(emotion.name)
                .padding()
                .background(emotion.color.getColor)
                .clipShape(Capsule())
        }
    }
}

struct EmotionView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionView()
    }
}
