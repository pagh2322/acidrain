//
//  Word.swift
//  AcidRain
//
//  Created by peo on 2022/07/05.
//

import SpriteKit

class WordBlock: SKShapeNode {
    static var wordList: [WordBlock] = []
    static var sampleWordTexts: [String] = ["collection", "money", "square", "dynamic", "iPhone", "star", "name", "dear", "home", "today", "meet", "easy", "hard", "twenty", "year", "army", "bank", "water", "wallet", "sound", "play"]
    var wordLabel: SKLabelNode = {
        var wordLabel = SKLabelNode()
        wordLabel.fontColor = .white
        wordLabel.fontSize = CGFloat(Int.random(in: 16...32))
        wordLabel.text = WordBlock.sampleWordTexts[Int.random(in: 0...WordBlock.sampleWordTexts.count-1)]
        wordLabel.zPosition = 3
        return wordLabel
    }()
    
    override init() {
        super.init()
        
    }
    convenience init(_ rectOf: CGSize) {
        self.init()
        self.init(rectOf: self.wordLabel.frame.size)
        
        self.addChild(self.wordLabel)
        self.fillColor = .clear
        WordBlock.wordList.append(self)
        
        self.setPhysicsBody()
        
        let randomX = CGFloat.random(in: -(UIScreen.main.bounds.width / 2.0)...(UIScreen.main.bounds.width / 2.0))
        self.position = CGPoint(
            x: randomX,
            y: (Consts.GameScene.size.height / 2.0) - self.wordLabel.frame.height - 20
        )
    }
    
    func setPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.wordLabel.frame.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = 0x1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isEqualTo(_ text: String) -> Bool {
        return text == self.wordLabel.text
    }
}
