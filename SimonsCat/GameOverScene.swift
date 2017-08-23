//
//  GameOverScene.swift
//  SimonsCat
//
//  Created by Anna on 21.08.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    let sceneManager = SceneManager.shared
    let score = Best ()
    var places: [Int]!
    
    override func didMove(to view: SKView) {
        
        score.loadScores()
        places = score.highscore
        
        self.backgroundColor = SKColor(red: 210 / 255, green: 56 / 255, blue: 54 / 255, alpha: 1.0)
        
        
        // MARK: - Button
        
        let restart = ButtonNode(titled: "restart", backgroundName: "button")
        restart.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        restart.name = "restart"
        restart.label.name = "restart"
        addChild(restart)
        
        
        // MARK: - BG cat
        
        let textureCat = SKTexture(imageNamed: "cat_bg_first_screen")
        let backgroundCat = SKSpriteNode(texture: textureCat)
        backgroundCat.position = CGPoint(x: self.frame.midX, y: 100.0)
        self.addChild(backgroundCat)
        
        
        // MARK: - Best
        
        let top =  SKLabelNode(text: "Best:")
        top.fontColor = UIColor.white
        top.fontName = "ChalkboardSE-Light"
        top.fontSize = 20
        top.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 30)
        addChild(top)
        
        for (index, value) in places.enumerated() {
            let l = SKLabelNode(text: value.description)
            l.fontColor = UIColor.white
            l.fontName = "ChalkboardSE-Light"
            l.fontSize = 20
            l.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - CGFloat((index + 2) * 30))
            addChild(l)
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
        }
    }
}
