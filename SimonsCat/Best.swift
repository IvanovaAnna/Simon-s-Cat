//
//  Best.swift
//  SimonsCat
//
//  Created by Anna on 23.08.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import UIKit

class Best: NSObject {
    
    let userDefaults = UserDefaults.standard
    
    var highscore: [Int] = []
    var currentScore = 0
    let highscoreKey = "highscore"
    var highscoreCount = 3
    
    override init() {
        super.init()
        loadScores()
    }
    
    func saveScores() {
        highscore.append(currentScore)
        if highscoreCount > highscore.count {
            highscoreCount = highscore.count
        }
        highscore = Array(highscore.sorted { $0 > $1 } .prefix(highscoreCount))
        userDefaults.set(highscore, forKey: highscoreKey)
        userDefaults.synchronize()
    }
    
    func loadScores() {
        guard userDefaults.value(forKey: highscoreKey) != nil else { return }
        highscore = userDefaults.array(forKey: highscoreKey) as! [Int]
    }
    
}
