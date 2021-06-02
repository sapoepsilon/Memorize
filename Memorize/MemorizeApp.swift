//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 2/22/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
//            let game = EmojiMex`moryGame()
//            ContentView(viewModel: game)
            let store = ThemeDocument()
            ChooseTheme().environmentObject(store)
        }
    }
}
