//
//  Array + Only.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 5/5/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
