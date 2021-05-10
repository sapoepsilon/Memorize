//
//  Cardify.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 5/10/21.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var theme: [Color]
    
    
    func body(content: Content) -> some View {
        if isFaceUp{
            RoundedRectangle(cornerRadius: cornerRadius).fill().foregroundColor(theme.first)
            RoundedRectangle(cornerRadius: cornerRadius).stroke( lineWidth: edgeLineWidth)
            content
        } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill( LinearGradient(gradient: Gradient(colors:  theme), startPoint: .bottom, endPoint: .top))
            }
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
}

extension View {
    func cardify(isFaceUp: Bool, themeColor: [Color]) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, theme: themeColor ))
    }
}
