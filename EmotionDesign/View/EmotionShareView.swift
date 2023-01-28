//
//  EmotionShareView.swift
//  EmotionDesign
//
//  Created by Дмитрий Гордиенко on 25.01.2023.
//

import SwiftUI

struct EmotionShareView: View {
    var body: some View {
        NavigationLink(destination: EmotionContentsView() ) {
            Image(systemName: "plus")
        }
    }
}

struct EmotionShareView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionShareView()
    }
}
