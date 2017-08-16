//
//  BitMaskCategory.swift
//  SimonsCat
//
//  Created by Anna on 15.08.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import Foundation

struct BitMaskCategory {
    //000000000....01
    static let cat: UInt32 = 0x1 << 0
    //000000000....10
    static let food: UInt32 = 0x1 << 1
    //000000000...100
    static let notFood: UInt32 = 0x1 << 2
}
