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
    
    let sceneManager = SceneManager.shared
    
    fileprivate var player: Cat!
    fileprivate var objectsOnTheFloor = ObjectsOnTheFloor ()
    fileprivate let gameInterface = GameInterface ()
    fileprivate let score = Best ()
    fileprivate let screenSize = UIScreen.main.bounds.size
    
    
    // MARK: - To hide lives
    
    fileprivate var lives = 3 {
        didSet {
            switch lives {
            case 3:
                gameInterface.life1.isHidden = false
                gameInterface.life2.isHidden = false
                gameInterface.life3.isHidden = false
            case 2:
                gameInterface.life1.isHidden = false
                gameInterface.life2.isHidden = false
                gameInterface.life3.isHidden = true
            case 1:
                gameInterface.life1.isHidden = false
                gameInterface.life2.isHidden = true
                gameInterface.life3.isHidden = true
            default:
                break
            }
        }
    }
    
    
    // MARK: - Score and level
    
    fileprivate var scoreForLevel = 1 {
        didSet {
            gameInterface.score += 10
            if scoreForLevel % 5 == 0 {
                gameInterface.level += 1
                print(scoreForLevel)
                objectsOnTheFloor.movementSpeed += 10
                if objectsOnTheFloor.distanceForRandom > 40 {
                    objectsOnTheFloor.distanceForRandom -= 5
                }
            }
        }
    }
    
    
    // MARK: - func didMove
    
    override func didMove(to view: SKView) {
        
        //turn off pause
        self.scene?.isPaused = false
        
        //checking if scene persists
        guard sceneManager.gameScene == nil  else { return }
        sceneManager.gameScene = self
        
        physicsWorld.contactDelegate = self
        //without gravity
        physicsWorld.gravity = CGVector.zero
        
        configureStartScene ()
        spawnObjectsOnTheFloor ()
        player.performMove()
        createGameInterface ()
    }
    
    
    fileprivate func createGameInterface () {
        addChild(gameInterface)
        gameInterface.configureUI(screenSize: screenSize)
    }
    
    // MARK: - Add new objects
    
    fileprivate func spawnObjectsOnTheFloor () {
        //pause
        let spawnObjectWait = SKAction.wait(forDuration: 2)
        //add random object
        let spawnObjectAction = SKAction.run {
            let object = self.objectsOnTheFloor.populate(at: nil)
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
        let itemsOnTheFloor = objectsOnTheFloor.populate(at: CGPoint(x: screen.size.width / 3, y: screen.size.height))
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
    
    
    // MARK: - Touch button pause
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //area where the touch occurs
        let location = touches.first!.location(in: self)
        //object in touch
        let node = self.atPoint(location)
        //if you press the button
        if node.name == "pause" {
            //transition animation
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let pauseScene = PauseScene(size: self.size)
            pauseScene.scaleMode = .aspectFill
            //save scene
            sceneManager.gameScene = self
            //turn on pause
            self.scene?.isPaused = true
            //transition
            self.scene!.view?.presentScene(pauseScene, transition: transition)
        }
    }
    
}


// MARK: - Physics contact

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        
        switch contactCategory {
        case [.cat, .notFood]:
        if contact.bodyA.node?.name == "оbjectsOnTheFloor" {
            if contact.bodyA.node?.parent != nil {
                contact.bodyA.node?.removeFromParent()
                lives -= 1
            }
        } else if contact.bodyB.node?.name == "оbjectsOnTheFloor" {
            if contact.bodyB.node?.parent != nil {
                contact.bodyB.node?.removeFromParent()
                lives -= 1
            }
        }
        case [.cat, .food]:
        if contact.bodyA.node?.name == "оbjectsOnTheFloor" {
            contact.bodyA.node?.removeFromParent()
            scoreForLevel += 1

        } else if contact.bodyB.node?.name == "оbjectsOnTheFloor" {
            contact.bodyB.node?.removeFromParent()
            scoreForLevel += 1
            }
        default:
            preconditionFailure("Unable to detect collision category")
        }
        if lives == 0 {
            score.currentScore = gameInterface.score
            score.saveScores()
            let gameOverScene = GameOverScene(size: self.size)
            let transition = SKTransition.crossFade(withDuration: 1.0)
            gameOverScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameOverScene, transition: transition)
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}



















