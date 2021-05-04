//
//  Grid.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 5/3/21.
//

import SwiftUI

struct Grid<Item, ItemView>: View {
    
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    
    }
    
    var body: some View {
        Text("Hwll")
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid()
    }
}
