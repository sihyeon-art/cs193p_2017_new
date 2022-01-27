//
//  SetEngine.swift
//  Set_Practice
//
//  Created by 박시현 on 2022/01/27.
//

import Foundation

struct SetEngine {
    
    private(set) var deck = [Card]()
    private(set) var score = 0
    
    var numberOfCard: Int {
        return deck.count
    }
    
    private(set) var cardOnTable = [Card]()
    private var selectedCard = [Card]()
    // var hintCard = [Int]()
    
    mutating func chooseCard(at index: Int) {
        if selectedCard.contains(cardOnTable[index]) {
            selectedCard.remove(at: selectedCard.firstIndex(of: cardOnTable[index])!)
            return
        }
        if selectedCard.count == 3 {
            if isSet(on: selectedCard) {
                for cards in selectedCard {
                    cardOnTable.remove(at: cardOnTable.firstIndex(of: cards)!)
                }
                selectedCard.removeAll()
                draw()
                score += 1
            } else {
                score -= 1
            }
        }
        selectedCard += [cardOnTable[index]]
    }
    
    mutating func isSet(on selectedCard: [Card]) -> Bool {
      
        let color = Set(selectedCard.map{ $0.color }).count
        let shape = Set(selectedCard.map{ $0.shape }).count
        let number = Set(selectedCard.map{ $0.number }).count
        let fill = Set(selectedCard.map{ $0.fill }).count
        
        
        return color != 2 && shape != 2 && number != 2 && fill != 2
    }
    
    // TODO: hint
    
    mutating func draw() {
        if deck.count > 0 {
            for _ in 1...3 {
                cardOnTable += [deck.remove(at: deck.randomIndex)]
            }
        }
    }
    
    private mutating func initDeck() {
        for _ in 1...4 {
            draw()
        }
    }
    
    init() {
        for color in Card.Color.all {
            for number in Card.Number.all {
                for shape in Card.Shape.all {
                    for fill in Card.Fill.all {
                        let card = Card(with: color, number, shape, fill)
                        deck += [card]
                    }
                }
            }
        }
        initDeck()
    }
    
    
}

extension Array {
    
    var randomIndex: Int {
        return Int(arc4random_uniform(UInt32(count - 1)))
    }
    
    
}
