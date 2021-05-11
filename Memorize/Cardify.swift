//
//  Cardify.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 5/10/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var theme: [Color]
    var rotation: Double
    
    init(isFaceUp: Bool, theme: [Color]) {
        rotation = isFaceUp ? 0 : 180
        self.theme = theme
        
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    var animatableData: Double {
        get {   return rotation    }
        set { rotation = newValue  }
    }
    
    
    func body(content: Content) -> some View {
        ZStack{
            Group{
                RoundedRectangle(cornerRadius: cornerRadius).fill().foregroundColor(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke( lineWidth: edgeLineWidth)
                content
            }.opacity(isFaceUp ? 1 : 0)
        
                RoundedRectangle(cornerRadius: cornerRadius).fill( LinearGradient(gradient: Gradient(colors:  theme), startPoint: .bottom, endPoint: .top))
                    .opacity(isFaceUp ? 0 : 1)
            
            
        }.rotation3DEffect(
            Angle.degrees(rotation),
            axis: (x: 0.0, y: 1, z: 0.0))
        
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
}

extension View {
    func cardify(isFaceUp: Bool, themeColor: [Color]) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, theme: themeColor))
    }
}
