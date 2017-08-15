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
    var animationSpriteArray = [SKTexture]()
    
    static func populate(at point: CGPoint) -> Cat {
        let catTexture = Assets.shared.simonsCatAtlas.textureNamed("SimonsCat5")
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
        moveCat()
    }
    
    //add pictures to the array
    fileprivate  func catAnimationFillArray () {
        for i in 1...9 {
            let number = String(format: "%d", i)
            let texture = Assets.shared.simonsCatAtlas.textureNamed("SimonsCat\(number)")
            animationSpriteArray.append(texture)
        }
    }
    
    fileprivate func moveCat() {
        catAnimationFillArray ()
        //animation in both directions
        let forwardAction = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.08, resize: true, restore: false)
        let backwardAction = SKAction.animate(with: self.animationSpriteArray.reversed(), timePerFrame: 0.08, resize: true, restore: false)
        let sequenceAction = SKAction.sequence([forwardAction, backwardAction])
        let moveForever = SKAction.repeatForever(sequenceAction)
        self.run(moveForever)
    }
}














