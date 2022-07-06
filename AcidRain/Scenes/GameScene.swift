//
//  GameScene.swift
//  AcidRain
//
//  Created by peo on 2022/07/05.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var isStart = true
    var word: WordBlock?
    
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
        self.attackTargetIfVisible()
    }
}

extension GameScene {
    func initialize() {
        self.backgroundColor = .black
        self.setPhysics()
        self.initWord()
    }
    
    func setPhysics() {
        self.scene?.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.scene?.physicsWorld.gravity = CGVector(dx: 0, dy: -4.9)
    }
    
    func initWord() {
        self.word = WordBlock(.zero)
        self.addChild(self.word!)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.createNewWord()
        }
    }
    
    func createNewWord() {
        if self.isStart {
            let newWord = WordBlock(.zero)
            self.addChild(newWord)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                self.createNewWord()
            }
        }
    }
}

extension GameScene {
    func detectWordBlock() -> Bool {
        let rayStart = CGPoint(x: -180, y: (Consts.GameScene.size.height / 2.0 - 20))
        let rayEnd = CGPoint(x: UIScreen.main.bounds.width, y: (Consts.GameScene.size.height / 2.0 - 20))
        
        let body = self.physicsWorld.body(alongRayStart: rayStart, end: rayEnd)
        
        
        return body?.categoryBitMask == self.word?.physicsBody?.categoryBitMask
    }

    func attackTargetIfVisible() {
        if self.detectWordBlock() {
            print("222")
        }
    }
}
