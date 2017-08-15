//
//  MenuScene.swift
//  SimonsCat
//
//  Created by Anna on 15.08.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: 210 / 255, green: 56 / 255, blue: 54 / 255, alpha: 1.0)
        let texture = SKTexture(imageNamed: "playbutton")
        let button = SKSpriteNode(texture: texture)
        //middle of the screen
        button.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        button.setScale(0.5)
        button.name = "runButton"
        
        let textureCat = SKTexture(imageNamed: "cat_bg_first_screen")
        let backgroundCat = SKSpriteNode(texture: textureCat)
        backgroundCat.position = CGPoint(x: self.frame.midX, y: 100.0)
        
        self.addChild(button)
        self.addChild(backgroundCat)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //area where the touch occurs
        let location = touches.first!.location(in: self)
        //object in touch
        let node = self.atPoint(location)
        //if you press the button
        if node.name == "runButton" {
            //transition animation
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            //transition
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }
    }

}
