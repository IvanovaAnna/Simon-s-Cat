//
//  GameScene.swift
//  SimonsCat
//
//  Created by Anna on 08.08.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: Cat!
    let scoreBackground = SKSpriteNode(imageNamed: "label_red")
    let scoreLabel = SKLabelNode(text: "1000")
    let menuButton = SKSpriteNode(imageNamed: "menu")
    let life1 = SKSpriteNode(imageNamed: "heart")
    let life2 = SKSpriteNode(imageNamed: "heart")
    let life3 = SKSpriteNode(imageNamed: "heart")
    
    
    // MARK: - func didMove
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        //without gravity
        physicsWorld.gravity = CGVector.zero
        
        configureStartScene ()
        spawnObjectsOnTheFloor ()
        player.performMove()
        configureUI ()
    }
    
    
    // MARK: - ConfigureUI
    
    fileprivate func configureUI () {
        //add label background
        scoreBackground.setScale(0.6)
        scoreBackground.position = CGPoint(x: scoreBackground.size.width + 5, y: self.size.height - scoreBackground.size.height / 2 - 5)
        scoreBackground.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        scoreBackground.zPosition = 90
        
        addChild(scoreBackground)
        
        //add label text
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: -12, y: 0)
        scoreLabel.zPosition = 100
        scoreLabel.fontName = "ChalkboardSE-Bold"
        scoreLabel.fontSize = 30
        scoreBackground.addChild(scoreLabel)
        
        //add menu
        menuButton.position = CGPoint(x: 5, y: 5)
        menuButton.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        menuButton.zPosition = 100
        menuButton.setScale(0.5)
        addChild(menuButton)
        
        let lifes = [life1, life2, life3]
        for (index, life) in lifes.enumerated() {
            life.setScale(0.3)
            life.position = CGPoint(x: self.size.width - CGFloat(index + 1) * (life.size.width + 3), y: 5)
            life.zPosition = 100
            life.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            addChild(life)
        }
    }
    
    
    // MARK: - Add new objects
    
    fileprivate func spawnObjectsOnTheFloor () {
        //pause
        let ramdomTime = Double(arc4random_uniform(6) + 2)
        let spawnObjectWait = SKAction.wait(forDuration: ramdomTime)
        //add random object
        let spawnObjectAction = SKAction.run {
            let object = ObjectsOnTheFloor.populate(at: nil)
            self.addChild(object)
        }
        let spawnObjectSequence = SKAction.sequence([spawnObjectWait, spawnObjectAction])
        let spawnObjectForever = SKAction.repeatForever(spawnObjectSequence)
        run(spawnObjectForever)
    }
    
    
    // MARK: - Scene configuration
    
    fileprivate func configureStartScene () {
        //add background
        self.backgroundColor = SKColor.white
        let screen = UIScreen.main.bounds
        
        //add starting item
        let itemsOnTheFloor = ObjectsOnTheFloor.populate(at: CGPoint(x: screen.size.width / 3, y: screen.size.height))
        self.addChild(itemsOnTheFloor)
        
        //add a cat
        player = Cat.populate(at: CGPoint(x: screen.size.width / 2, y: 150))
        self.addChild(player)
    }
    
    
    // MARK: - func didSimulatePhysics
    
    override func didSimulatePhysics() {
        player.checkPosition()
        //delete items below the screen
        enumerateChildNodes(withName: "оbjectsOnTheFloor") { (node, stop) in
            if node.position.y < -100 {
                node.removeFromParent()
            }
        }
    }
}


    // MARK: - Physics contact

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        switch contactCategory {
        case [.cat, .notFood]: print("cat vs notFood")
            case [.cat, .food]: print("cat vs food")
        default:
            preconditionFailure("Unable to detect collision category")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}



















