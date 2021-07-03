//
//  ContentView.swift
//  Memorize
//
//  Created by Jonas on 24.05.21.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🌴", "🏙", "🇺🇸", "👨🏻‍💻", "🤷🏻‍♂️", "🥳", "⚓️", "🤓", "😇", "📋"]
    @State var emojiCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(emojis[..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(Color.purple)
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .padding(.horizontal)
            .font(.largeTitle)
        }
        .padding(.horizontal)
    }
    
    var remove: some View {
        Button {
            emojiCount = max(emojiCount - 1, 1)
        } label: {
            Image(systemName: "minus.circle.fill")
        }
    }
    var add: some View {
        Button {
            emojiCount = min(emojiCount + 1, emojis.count)
        } label: {
            Image(systemName: "plus.circle.fill")
        }
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = false
    var content: String
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
