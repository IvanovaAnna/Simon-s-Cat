//
//  GameInterface.swift
//  SimonsCat
//
//  Created by Anna on 16.08.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import SpriteKit

class GameInterface: SKNode {
    
    let scoreBackground = SKSpriteNode(imageNamed: "label_red")
    let scoreLabel = SKLabelNode(text: "1000")
    let menuButton = SKSpriteNode(imageNamed: "menu")
    let life1 = SKSpriteNode(imageNamed: "heart")
    let life2 = SKSpriteNode(imageNamed: "heart")
    let life3 = SKSpriteNode(imageNamed: "heart")
    
    
    // MARK: - ConfigureUI
    
    func configureUI (screenSize: CGSize) {
        //add label background
        scoreBackground.setScale(0.6)
        scoreBackground.position = CGPoint(x: scoreBackground.size.width + 5, y: screenSize.height - scoreBackground.size.height / 2 - 5)
        scoreBackground.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        scoreBackground.zPosition = 90
        
        addChild(scoreBackground)
        
        //add label text
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: -12, y: 0)
        scoreLabel.zPosition = 100
        scoreLabel.fontName = "ChalkboardSE-Bold"
        scoreLabel.fontSize = 30
        scoreBackground.addChild(scoreLabel)
        
        //add menu
        menuButton.position = CGPoint(x: 5, y: 5)
        menuButton.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        menuButton.zPosition = 100
        menuButton.setScale(0.5)
        menuButton.name = "pause"
        addChild(menuButton)
        
        let lifes = [life1, life2, life3]
        for (index, life) in lifes.enumerated() {
            life.setScale(0.3)
            life.position = CGPoint(x: screenSize.width - CGFloat(index + 1) * (life.size.width + 3), y: 5)
            life.zPosition = 100
            life.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            addChild(life)
        }
    }
}
