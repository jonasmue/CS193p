//
//  Cardify.swift
//  Memorize
//
//  Created by Jonas Müller on 02.06.20.
//  Copyright © 2020 compitencies. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }.shadow(radius: 2.0)
    }
    
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
