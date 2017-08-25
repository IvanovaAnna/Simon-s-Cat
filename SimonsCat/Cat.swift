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
    
    
    // MARK: - Add cat
    
    static func populate(at point: CGPoint) -> Cat {
        let catTexture = Assets.shared.simonsCatAtlas.textureNamed("SimonsCat5")
        let cat = Cat(texture: catTexture)
        cat.setScale(0.4)
        cat.position = point
        cat.zPosition = 10
        
        
        
        // MARK: - Physics body

        cat.physicsBody = SKPhysicsBody(texture: catTexture, alphaThreshold: 0.5, size: cat.size)
        //not move in a collision
        cat.physicsBody?.isDynamic = false
        //bit mask cat
        cat.physicsBody?.categoryBitMask = BitMaskCategory.cat.rawValue
        //bit mask food for a collision
        cat.physicsBody?.collisionBitMask = BitMaskCategory.notFood.rawValue | BitMaskCategory.food.rawValue
        cat.physicsBody?.contactTestBitMask = BitMaskCategory.notFood.rawValue | BitMaskCategory.food.rawValue
        
        return cat
    }
    
    // MARK: - Left and right move
    
    func checkPosition () {
        //moving the cat
        self.position.x += xAcceleration * 40
        //If the cat goes behind the screen - appears on the other side
        if self.position.x < -40 {
            self.position.x = screenSize.width + 40
        } else if self.position.x > screenSize.width + 40 {
            self.position.x = -40
        }
    }
    
    
    // MARK: - Accelerometer
    
    func performMove () {
        //how often to measure the acceleration
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [unowned self] (data, error) in
            //data from sensors
            if let data = data {
                let acceleration = data.acceleration
                //acceleration from inclination
                //Coefficient for nonlinearity
                self.xAcceleration = CGFloat(acceleration.x) * 0.4
            }
        }
        moveCat()
    }
    
    
    // MARK: - Add pictures to the array

    fileprivate  func catAnimationFillArray () {
        for i in 1...9 {
            let number = String(format: "%d", i)
            let texture = Assets.shared.simonsCatAtlas.textureNamed("SimonsCat\(number)")
            animationSpriteArray.append(texture)
        }
    }
    
    
    // MARK: - Animation cat
    
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














