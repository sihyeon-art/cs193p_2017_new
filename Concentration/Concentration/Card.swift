//
//  Card.swift
//  Concentration
//
//  Created by 박시현 on 2022/01/07.
//

import Foundation

struct Card: Hashable
{
    var hashValue: Int { return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var isSeenBefore = false
    
    private var identifier: Int
    
    private static var idendifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        idendifierFactory += 1
        return idendifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
        
    }
    
    
}




