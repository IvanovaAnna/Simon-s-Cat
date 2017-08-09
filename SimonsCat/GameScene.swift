//
//  GameScene.swift
//  SimonsCat
//
//  Created by Anna on 08.08.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import SpriteKit
import GameplayKit

//for the accelerometer
import CoreMotion

class GameScene: SKScene {
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    var player: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        configureStartScene ()
        spawnObjectsOnTheFloor ()
    }
    
    //add new objects
    fileprivate func spawnObjectsOnTheFloor () {
        //pause
        let spawnObjectWait = SKAction.wait(forDuration: 6)
        //add random object
        let spawnObjectAction = SKAction.run {
            let object = ObjectsOnTheFloor.populate()
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
        
        //add starting item (left bottom x: 75, y: 400)
        let itemsOnTheFloor1 = ObjectsOnTheFloor.populate(at: CGPoint(x: 75, y: 400))
        self.addChild(itemsOnTheFloor1)
        
        //add starting item (right top x: 100, y: 200)
        let itemsOnTheFloor2 = ObjectsOnTheFloor.populate(at: CGPoint(x: self.size.width - 100, y: self.size.height - 50))
        self.addChild(itemsOnTheFloor2)
        
        
        //add a cat
        player = Cat.populate(at: CGPoint(x: screen.size.width / 2, y: 150))
        self.addChild(player)
        
        //how often to measure the acceleration
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            //data from sensors
            if let data = data {
                let acceleration = data.acceleration
                //acceleration from inclination
                //Coefficient for nonlinearity
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
        //moving the cat
        player.position.x += xAcceleration * 50
        
        //If the cat goes behind the screen - appears on the other side
        if player.position.x < -70 {
            player.position.x = self.size.width + 70
        } else if player.position.x > self.size.width + 70 {
            player.position.x = -70
        }
    }
}



















