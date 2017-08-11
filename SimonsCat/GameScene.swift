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
    
    override func didMove(to view: SKView) {
        configureStartScene ()
        spawnObjectsOnTheFloor ()
        player.performMove()
    }
    
    //add new objects
    fileprivate func spawnObjectsOnTheFloor () {
        //pause
        let spawnObjectWait = SKAction.wait(forDuration: 4)
        //add random object
        let spawnObjectAction = SKAction.run {
            let object = ObjectsOnTheFloor.populate(at: nil)
            self.addChild(object)
        }
        let spawnObjectSequence = SKAction.sequence([spawnObjectWait, spawnObjectAction])
        let spawnObjectForever = SKAction.repeatForever(spawnObjectSequence)
        run(spawnObjectForever)
    }
    
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



















