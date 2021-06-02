//
//  themeDocument.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 5/26/21.
//

import SwiftUI

class ThemeDocument: ObservableObject {
    
    let defaults = UserDefaults.standard
    @Published var returnedEmoji : [EmojiMemoryTheme] = []
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "themes") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let note = try decoder.decode([EmojiMemoryTheme].self, from: data)
                returnedEmoji = note
                
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
    }
    
    
    func getName(theme: EmojiMemoryTheme) -> String{
        return theme.name
    }
    
    func getEmojiMemoryGame(for theme: EmojiMemoryTheme) -> EmojiMemoryGame {
        
        let emojiGame = EmojiMemoryGame(theme: theme)
        
        return emojiGame
    }
    
    func editTheme(for theme: EmojiMemoryTheme, emojis: String, emojiName: String, color: UIColor.RGB ) {
        
        let trimmedEmojis = emojis.trimmingCharacters(in: .whitespacesAndNewlines)
        let emojisArray = Array(trimmedEmojis)
        var emojiArray : [String] = []
        
        for emoji in emojisArray {
            emojiArray.append(String(emoji))
            returnedEmoji[theme.id].name = emojiName
        }
        returnedEmoji[theme.id].emoji = emojiArray
        returnedEmoji[theme.id].colorRGB = color
        returnedEmoji[theme.id].numberOfPairs = emojiArray.count
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            
            // Encode Note
            let data = try encoder.encode(returnedEmoji)
            
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "themes")
            
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func removeTheme(for theme: EmojiMemoryTheme) {
        
        returnedEmoji.remove(at: returnedEmoji.firstIndex(matching: theme)!)
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            // Encode Note
            let data = try encoder.encode(returnedEmoji)
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "themes")
            
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func createTheme(themeName: String, emojis: String, themeColor: Color) {
        //MARK: Create theme
        let trimmedEmojis = emojis.trimmingCharacters(in: .whitespacesAndNewlines)
        let emojisArray = Array(trimmedEmojis)
        let numberOfPairs = emojisArray.count
        let id =  returnedEmoji.count
        var emojiArray : [String] = []
        
        for emoji in emojisArray {
            
            let stringEmoji = String(emoji)
            emojiArray.append(stringEmoji)
        }
        
        let newEmojiTheme = EmojiMemoryTheme(name: themeName, emoji: emojiArray , colorRGB: UIColor(themeColor).rgb, numberOfPairs: numberOfPairs, id: id)
        
        returnedEmoji.append(newEmojiTheme)
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            
            // Encode Note
            let data = try encoder.encode(returnedEmoji)
            
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "themes")
            
        } catch {
            print("Unable to Encode Note (\(error))")
        }
        
    }
    
    func isThemeEmpty() -> Bool {
        
        if returnedEmoji.count == 0 {
            return true
        } else {
            return false
        }
        
    }
    
    //    private static func getTheme(themeID: Int) -> EmojiMemoryTheme {
    //
    //        p
    //
    //        return EmojiMemoryTheme().
    //
    //    }
    //
    
}
