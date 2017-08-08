//
//  Cat.swift
//  SimonsCat
//
//  Created by Anna on 08.08.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import SpriteKit

class Cat: SKSpriteNode {
    
    static func populate(at point: CGPoint) -> SKSpriteNode {
        let catTexture = SKTexture(imageNamed: "SimonsCat")
        let cat = SKSpriteNode(texture: catTexture)
        cat.setScale(0.4)
        cat.position = point
        cat.zPosition = 20
        return cat
    }

}
