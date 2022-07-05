//
//  Word.swift
//  AcidRain
//
//  Created by peo on 2022/07/05.
//

import SpriteKit

class Word: SKLabelNode {
    static var wordList: [Word] = []
    static var sampleWordTexts: [String] = ["collection", "money", "square", "dynamic", "iPhone", "star", "name", "dear", "home", "today", "meet", "easy", "hard"]
    
    override init() {
        super.init()
        self.fontColor = .red
        self.fontSize = CGFloat(Int.random(in: 12...32))
        self.text = Word.sampleWordTexts[Int.random(in: 0...12)]
        self.position = CGPoint(x: 0, y: 0)
        Word.wordList.append(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isEqualTo(_ text: String) -> Bool {
        return text == self.text
    }
}
