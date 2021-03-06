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
        
        if !Assets.shared.isLoaded {
            Assets.shared.preloadAtlas()
            Assets.shared.isLoaded = true
        }
        
        self.backgroundColor = SKColor(red: 210 / 255, green: 56 / 255, blue: 54 / 255, alpha: 1.0)
        
        
        // MARK: - Logo
        
        let textureHeader = SKTexture(imageNamed: "logo")
        let header = SKSpriteNode(texture: textureHeader)
        header.position = CGPoint(x: self.frame.midX, y: self.size.height - 50)
        header.anchorPoint = CGPoint(x: 0.5, y: 1)
        header.setScale(0.8)
        self.addChild(header)
        
        
        // MARK: - Button
        
        let button1 = ButtonNode(titled: "play", backgroundName: "button")
        button1.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        button1.name = "play"
        button1.label.name = "play"
        addChild(button1)
        
        
        // MARK: - BG cat
        
        let textureCat = SKTexture(imageNamed: "cat_bg_first_screen")
        let backgroundCat = SKSpriteNode(texture: textureCat)
        backgroundCat.position = CGPoint(x: self.frame.midX, y: 100.0)
        self.addChild(backgroundCat)
    }
    
    
    // MARK: - Touch button
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //area where the touch occurs
        let location = touches.first!.location(in: self)
        //object in touch
        let node = self.atPoint(location)
        //if you press the button
        if node.name == "play" {
            //transition animation
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            //transition
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }
    }

}
