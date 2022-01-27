//
//  ViewController.swift
//  Set_Practice
//
//  Created by 박시현 on 2022/01/26.
//

import UIKit

class ViewController: UIViewController {
    
    private var engine = SetEngine()
    private var selectedButton = [UIButton]()

    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var deal3MoreCardsButton: UIButton!
    
    // MARK: cardsButtonPressed 대체
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            if cardIndex < engine.cardOnTable.count {
                engine.chooseCard(at: cardIndex)
                chooseButton(at: sender)
                updateViewFromModel()
            }
        } else {
            print("chosen card was not in cardButtons")
        }
        print(selectedButton.count)
    }
    
    
    
    // TODO: updatescore()
    
    private func chooseButton(at card: UIButton) {
        if selectedButton.contains(card) {
            card.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            card.layer.borderWidth = 3.0
            selectedButton.remove(at: selectedButton.firstIndex(of: card)!)
            return
        } else if selectedButton.count == 3 {
                cardButtons.forEach() { $0.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) }
                selectedButton.removeAll()
                // updateScore()
            }
            selectedButton += [card]
            card.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            card.layer.borderWidth = 3.0
        }
    
    // MARK: moreThreeButtonPressed 대체
    @IBAction private func deal3MoreCardsButtonPressed(_ sender: UIButton) {
        if selectedButton.count == 3 {
            
        }
        engine.draw()
        updateViewFromModel()
        // TODO: hiddenButtonIfNeed()
    }
    
    // TODO: hintButtonPressed
    // TODO: newGameButtonPressed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    // TODO: hiddenButtonIfNeed()
    // TODO: resetButton()
    
    private func updateViewFromModel() {

        for index in engine.cardOnTable.indices {
            cardButtons[index].titleLabel?.numberOfLines = 0
            cardButtons[index].setAttributedTitle(setCardTitle(with: engine.cardOnTable[index]), for: .normal)
        }
    }
    
    private func setCardTitle(with card: Card) -> NSAttributedString {
        
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeColor: ModelToView.colors[card.color]!,
            .strokeWidth: ModelToView.strokeWidth[card.fill]!,
            .foregroundColor: ModelToView.colors[card.color]!.withAlphaComponent(ModelToView.alpha[card.fill]!),
            ]
        var cardTitle = ModelToView.shapes[card.shape]!
        switch card.number {
        case .two: cardTitle = "\(cardTitle)\n\(cardTitle)"
        case .three: cardTitle = "\(cardTitle)\n\(cardTitle)\n\(cardTitle)"
        default:
            break
        }
        
        return NSAttributedString(string: cardTitle, attributes: attributes)
    }
    

}

struct ModelToView {
    
    static let shapes: [Card.Shape: String] = [.circle: "●", .triangle: "▲", .square: "■"]
    static var colors: [Card.Color: UIColor] = [.red: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), .purple: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), .green: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)]
    static var alpha: [Card.Fill: CGFloat] = [.solid: 1.0, .empty: 0.40, .stripe: 0.15]
    static var strokeWidth: [Card.Fill: CGFloat] = [.solid: -5, .empty: 5, .stripe: -5]
}
