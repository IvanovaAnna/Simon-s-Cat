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
        //above the screen for 100-200
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height) + 100, highestValue: Int(screen.size.height) + 200)
        let y = CGFloat(distribution.nextInt())
        //from 0 to the width of the screen
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        return CGPoint(x: x, y: y)
    }
    
    //add objects
    static func populate ( ) -> ObjectsOnTheFloor {
        let objectImageName = configuraObjectsName ()
        let object = ObjectsOnTheFloor(imageNamed: objectImageName)
        object.setScale(0.8)
        object.position = randomPoint()
        object.zPosition = 1
        object.run(move(from: object.position))
        return object
    }
    
    static func populate (at point: CGPoint ) -> ObjectsOnTheFloor {
        let objectImageName = configuraObjectsName ()
        let object = ObjectsOnTheFloor(imageNamed: objectImageName)
        object.setScale(0.8)
        object.position = point
        object.zPosition = 1
        object.run(move(from: object.position))
        return object
    }
    
    //random number for objects
    fileprivate static func configuraObjectsName () -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 4)
        let randomNumber = distribution.nextInt()
        let imageName = "notFood" + "\(randomNumber)"
        return imageName
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
