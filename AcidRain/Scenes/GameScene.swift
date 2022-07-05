//
//  GameScene.swift
//  AcidRain
//
//  Created by peo on 2022/07/05.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var word: Word?
    
    override func didMove(to view: SKView) {
        self.initialize()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene {
    func initialize() {
        self.backgroundColor = .blue
        self.setPhysics()
        self.initWord()
    }
    
    func setPhysics() {
        self.scene?.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.scene?.physicsWorld.gravity = .zero
    }
    
    func initWord() {
        self.word = Word()
        self.addChild(self.word!)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.createNewWord()
        }
    }
    
    func createNewWord() {
        let newWord = Word()
        newWord.position = CGPoint(x: CGFloat.random(in: -(UIScreen.main.bounds.width / 2.0)...(UIScreen.main.bounds.width / 2.0)), y: CGFloat.random(in: -150.0...150.0))
        self.addChild(newWord)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
            self.createNewWord()
        }
    }
}
