//
//  ObjectsOnTheFloor.swift
//  SimonsCat
//
//  Created by Anna on 08.08.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import SpriteKit
import GameplayKit

class ObjectsOnTheFloor: SKSpriteNode {
    
    //add random point
    static func randomPoint () -> CGPoint {
        let screen = UIScreen.main.bounds
        //above the screen for 50-100
        let distributionY = GKRandomDistribution(lowestValue: Int(screen.size.height) + 50, highestValue: Int(screen.size.height) + 100)
        let y = CGFloat(distributionY.nextInt())
        //from 50 to the width of the screen - 50
        let distributionX = GKRandomDistribution(lowestValue: 50, highestValue: Int(screen.size.width) - 50)
        let x = CGFloat(distributionX.nextInt())

        return CGPoint(x: x, y: y)
    }
    
    //add objects
    static func populate (at point: CGPoint? ) -> ObjectsOnTheFloor {
        
        let objectTexture = Assets.shared.foodOrNotFood.textureNamed(configuraObjectsName().imageName)
        let object = ObjectsOnTheFloor(texture: objectTexture)
        
        object.setScale(0.3)
        //if no point - a random point
        object.position = point ?? randomPoint()
        object.zPosition = 10
        //add name for removing
        object.name = "оbjectsOnTheFloor"
        //move the middle up (y) for removing
        object.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        object.run(move(from: object.position))
        
        //physics body
        object.physicsBody = SKPhysicsBody(texture: objectTexture, alphaThreshold: 0.5, size: object.size)
        //move in a collision
        object.physicsBody?.isDynamic = true
        
         //bit mask cat
        let objectfood = configuraObjectsName().thisIsFood
        if objectfood == true {
            object.physicsBody?.categoryBitMask =  BitMaskCategory.food
        } else {
            object.physicsBody?.categoryBitMask = BitMaskCategory.notFood
        }
        object.physicsBody?.collisionBitMask = BitMaskCategory.cat
        object.physicsBody?.contactTestBitMask = BitMaskCategory.cat
        
        return object
    }
    
    //random number for objects
    fileprivate static func configuraObjectsName () -> (imageName: String, thisIsFood: Bool) {
        
        let distributionImg = GKRandomDistribution(lowestValue: 1, highestValue: 4)
        let randomNumber = distributionImg.nextInt()
        
        let distributionfoodOrNotFood = GKRandomDistribution(lowestValue: 1, highestValue: 2)
        let foodOrNotFood = distributionfoodOrNotFood.nextInt()
        
        var imageName = String()
        var thisIsFood = Bool()
        if foodOrNotFood == 1 {
            imageName = "notFood" + "\(randomNumber)"
            thisIsFood = false
        } else {
            imageName = "food" + "\(randomNumber)"
            thisIsFood = true
        }
        print(thisIsFood)
        return (imageName, thisIsFood)
    }
    
    //move the object vertically
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 50.0
        let duratiom = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duratiom))
        
    }
    

}
