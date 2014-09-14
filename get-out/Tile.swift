//
//  Tile.swift
//  get-out
//
//  Created by Cor Pruijs on 14-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class Tile {
    
    let sprite = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 100, height: 100))
    
    init() {
        println("much init")
        sprite.position = CGPoint(x: 0, y: 0)
        
    }

}