//
//  ViewController.swift
//  Concentration
//
//  Created by 박시현 on 2022/01/04.
//

import UIKit

class ViewController: UIViewController
{
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1) / 2
    }
    
    func updateScoreLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Score: \(game.score)", attributes: attributes)
        scoreLabel.attributedText = attributedString
    }
    
    func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : themeColorButton
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBAction private func touchCard(_ sender: UIButton) {
        // flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            // flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        setup()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : themeColorButton
            }
        }
        updateFlipCountLabel()
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private var animals: String = "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮"
    private var sports: String = "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸🥅🏒"
    private var faces: String = "😀😃😄😁😆😅😂🤣☺️😊😇🙂"
    private var cars: String = "🚗🚕🚙🚌🚎🏎🚓🚑🚒🚐🚚🚛"
    private var flags: String = "🇹🇼🇯🇵🏳️🏴🏁🚩🏳️‍🌈🇱🇷🎌🇨🇦🇳🇵🇬🇪"
    private var foods: String = "🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑"
    private var theme: [String] = []
    private var randomTheme: String = "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮"
    private var themeColorButton: UIColor = #colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 1)
    private var themeColorBackground: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    private func setupTheme() {
        theme = [animals, sports, faces, cars, flags, foods]
        randomTheme = getRandomTheme()
    }

    private var emoji = [Card:String]()
    private func emoji(for card: Card) -> String {
         if emoji[card] == nil, randomTheme.count > 0 {
             let randomStringIndex = randomTheme.index(randomTheme.startIndex, offsetBy: randomTheme.count.arc4random)
             emoji[card] = String(randomTheme.remove(at: randomStringIndex))
    }
         return emoji[card] ?? "?"
     }
    
    private func getRandomTheme() -> String {
        let index = theme.count.arc4random
        print(theme[index])
        setColor(at: index)
        return theme[index]
    }
    
    private func setColor(at theme: Int) {
        switch theme {
        case 0:
            themeColorButton = #colorLiteral(red: 0.4274509804, green: 0.737254902, blue: 0.3882352941, alpha: 1)
            themeColorBackground = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        case 1:
            themeColorButton = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            themeColorBackground = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
        case 2:
            themeColorButton = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
            themeColorBackground = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case 3:
            themeColorButton = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            themeColorBackground = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case 4:
            themeColorButton = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            themeColorBackground = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        case 5:
            themeColorButton = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            themeColorBackground = #colorLiteral(red: 0.4274509804, green: 0.737254902, blue: 0.3882352941, alpha: 1)
        default:
            themeColorButton = #colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 1)
            themeColorBackground = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }

    }
    
    
    private func setup() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        setupTheme()
        updateViewFromModel()
        view.backgroundColor = themeColorBackground
        for cards in cardButtons {
            cards.backgroundColor = themeColorButton
        }
        scoreLabel.textColor = themeColorButton
        newGameButton.setTitleColor(themeColorButton, for: .normal)
    }
    
//    // MARK: lifeCycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTheme()
//        setup()
//    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
        
    }
}

