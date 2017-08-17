//
//  BitMaskCategory.swift
//  SimonsCat
//
//  Created by Anna on 15.08.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import SpriteKit

extension SKPhysicsBody {
    var category: BitMaskCategory {
        get {
            return BitMaskCategory(rawValue: self.categoryBitMask)
        }
        set {
            self.categoryBitMask = newValue.rawValue
        }
    }
}

struct BitMaskCategory: OptionSet {
    let rawValue: UInt32
    
    static let none = BitMaskCategory(rawValue: 0 << 0)
    static let cat = BitMaskCategory(rawValue: 1 << 0)
    static let food = BitMaskCategory(rawValue: 1 << 1)
    static let notFood = BitMaskCategory(rawValue: 1 << 2)
    static let all = BitMaskCategory(rawValue: UInt32.max)
}
