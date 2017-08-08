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
    
    //add objects
    static func populateObjects(at point: CGPoint) -> ObjectsOnTheFloor {
        let objectImageName = configuraObjectsName ()
        let object = ObjectsOnTheFloor(imageNamed: objectImageName)
        object.setScale(0.8)
        object.position = point
        object.zPosition = 1
        object.run(move(from: point))
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
        let movementSpeed: CGFloat = 10.0
        let duratiom = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duratiom))
        
    }
    

}
