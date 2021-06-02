//
//  memorizeTheme.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 5/24/21.
//

import SwiftUI

struct EmojiMemoryTheme: Codable, Identifiable, Equatable {
    var id: Int
    var name: String
    var emoji: [String]
    var colorRGB: UIColor.RGB
    var numberOfPairs: Int

    var color: Color {
        Color(colorRGB)
    }

    var json: Data? {
        try? JSONEncoder().encode(self)
    }
    
    init(name: String, emoji: [String], colorRGB: UIColor.RGB, numberOfPairs: Int, id: Int) {
        self.name = name
        self.emoji = emoji
        self.colorRGB = colorRGB
        self.numberOfPairs = numberOfPairs
        self.id = id
    }

    init?(json: Data?) {
        if let json = json, let newEmojiTheme = try? JSONDecoder().decode(EmojiMemoryTheme.self, from: json) {
            self = newEmojiTheme
        }
        else {
            return nil
        }
    }

        
    }

