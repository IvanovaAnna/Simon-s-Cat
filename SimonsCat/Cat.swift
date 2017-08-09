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
    
    static func populate(at point: CGPoint) -> Cat {
        let catTexture = SKTexture(imageNamed: "SimonsCat")
        let cat = Cat(texture: catTexture)
        cat.setScale(0.4)
        cat.position = point
        cat.zPosition = 20
        return cat
    }
    
    func checkPosition () {
        //moving the cat
        self.position.x += xAcceleration * 50
        
        //If the cat goes behind the screen - appears on the other side
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
    func performMove () {
        //how often to measure the acceleration
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            //data from sensors
            if let data = data {
                let acceleration = data.acceleration
                //acceleration from inclination
                //Coefficient for nonlinearity
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
    }

}
