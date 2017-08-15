//
//  Assets.swift
//  SimonsCat
//
//  Created by Anna on 15.08.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import SpriteKit

class Assets {
    static let shared = Assets ( )
    let simonsCatAtlas = SKTextureAtlas(named: "SimonsCat")
    func preloadAtlas ( ) {
        simonsCatAtlas.preload {
            print("preload Atlas")
        }
    }
}
