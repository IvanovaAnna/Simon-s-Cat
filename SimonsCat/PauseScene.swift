//
//  PauseScene.swift
//  SimonsCat
//
//  Created by Anna on 21.08.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import SpriteKit

class PauseScene: SKScene {
    
    let sceneManager = SceneManager.shared
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor(red: 210 / 255, green: 56 / 255, blue: 54 / 255, alpha: 1.0)
        
        
        // MARK: - Button
        
        let titles = ["restart", "resume"]
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(titled: title, backgroundName: "button")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - CGFloat(100 * (index + 1)))
            button.name = title
            button.label.name = title
            addChild(button)
        }
        
        
        // MARK: - BG cat
        
        let textureCat = SKTexture(imageNamed: "cat_bg_first_screen")
        let backgroundCat = SKSpriteNode(texture: textureCat)
        backgroundCat.position = CGPoint(x: self.frame.midX, y: 100.0)
        self.addChild(backgroundCat)
    }
    
    //debug pause
    override func update(_ currentTime: TimeInterval) {
        if let gameScene = sceneManager.gameScene {
            if !gameScene.isPaused {
                gameScene.isPaused = true
            }
        }
    }
    
    
    // MARK: - Touch button
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //area where the touch occurs
        let location = touches.first!.location(in: self)
        //object in touch
        let node = self.atPoint(location)
        //if you press the button "restart"
        if node.name == "restart" {
            sceneManager.gameScene = nil
            //transition animation
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
            
            //if you press the button "resume"
        } else if node.name == "resume" {
            //transition animation
            let transition = SKTransition.crossFade(withDuration: 1.0)
            guard let gameScene = sceneManager.gameScene else { return }
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }
    }

}
