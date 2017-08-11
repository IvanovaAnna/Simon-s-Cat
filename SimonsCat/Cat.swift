//
//  Cat.swift
//  SimonsCat
//
//  Created by Anna on 08.08.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import SpriteKit
//for the accelerometer
import CoreMotion

class Cat: SKSpriteNode {
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    var forwardTextureArrayAnimation = [SKTexture]()
    
    static func populate(at point: CGPoint) -> Cat {
        let catTexture = SKTexture(imageNamed: "SimonsCat5")
        let cat = Cat(texture: catTexture)
        cat.setScale(0.4)
        cat.position = point
        cat.zPosition = 10
        return cat
    }
    
    func checkPosition () {
        //moving the cat
        self.position.x += xAcceleration * 50
        //If the cat goes behind the screen - appears on the other side
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
    func performMove () {
        catAnimationFillArray ()
        //how often to measure the acceleration
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [unowned self] (data, error) in
            //data from sensors
            if let data = data {
                let acceleration = data.acceleration
                //acceleration from inclination
                //Coefficient for nonlinearity
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
        
        let catWaitAction = SKAction.wait(forDuration: 1.0)
        let catDirectionCheckAction = SKAction.run { [unowned self] in
            self.moveCat()
        }
        let catSequence = SKAction.sequence([catWaitAction, catDirectionCheckAction])
        let catSequenceForever = SKAction.repeatForever(catSequence)
        self.run(catSequenceForever)
    }
    
    //add pictures to the array
    fileprivate  func catAnimationFillArray () {
        SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "SimonsCat")]) {
            self.forwardTextureArrayAnimation = {
                var array = [SKTexture] ()
                for i in stride(from: 1, through: 9, by: 1) {
                    let number = String(format: "%d", i)
                    let texture = SKTexture(imageNamed: "SimonsCat\(number)")
                    array.append(texture)
                }
                SKTexture.preload(array, withCompletionHandler: {
//                    print("preload is done")
                })
                return array
            } ()
        }
    }
    
    fileprivate func moveCat() {
        //animation in both directions
        let forwardAction = SKAction.animate(with: forwardTextureArrayAnimation, timePerFrame: 0.05, resize: true, restore: false)
        let backwardAction = SKAction.animate(with: forwardTextureArrayAnimation.reversed(), timePerFrame: 0.05, resize: true, restore: false)
        let sequenceAction = SKAction.sequence([forwardAction, backwardAction])
        run(sequenceAction)
    }
}














