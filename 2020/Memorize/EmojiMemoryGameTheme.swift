//
//  EmojiMemoryGameThemes.swift
//  Memorize
//
//  Created by Jonas Müller on 01.06.20.
//  Copyright © 2020 compitencies. All rights reserved.
//

import SwiftUI

public struct Theme {
    var name: String
    var contents: [String]
    var numCardPairs: Int?
    var color: Color
}

class EmojiMemoryGameThemeFactory {
    private static let themes = [
        Theme(name: "Halloween",
              contents: ["🦓", "🦒", "🐔", "🐰", "🐡", "🐍", "🐋", "🐥", "🐦", "🦊", "🦮", "🐙", "🐮", "🦋", "🐘", "🦞", "🦚", "🦘", "🐼", "🦆", "🦇", "🐧"],
              numCardPairs: nil,
              color: .orange),
        Theme(name: "Food",
              contents: ["🧀", "🥕", "🍩", "🌽", "🍶", "🍺", "🍏", "🍞", "🍪", "🧇", "🌯", "🍑", "🍱", "🥒", "🥑", "🍔", "🍰", "🍋", "🍉", "🧆", "🥯", "🥗", "🍟"],
              numCardPairs: nil,
              color: .red),
        Theme(name: "Vehicles",
              contents: ["🚛", "🚚", "🚲", "🚠", "🏎", "🚝", "🛥", "🚁"],
              numCardPairs: 8,
              color: .gray),
        Theme(name: "Faces",
              contents: ["😙", "😮", "🤕", "😋", "😷", "😊", "🤖", "🤓"],
              numCardPairs: nil,
              color: .yellow),
        Theme(name: "Sports",
              contents: ["🏈", "⚾️", "⚽️", "🥍", "⛸", "🏀"],
              numCardPairs: 6,
              color: .blue)]

    public static func getRandomTheme() -> Theme {
        themes.randomElement()!
    }
}

