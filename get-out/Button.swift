//
//  Button.swift
//  get-out
//
//  Created by Cor Pruijs on 09-10-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class Button {
    
    let sprite: SKSpriteNode
    
    
    init() {
        sprite = SKSpriteNode(imageNamed: "button")
        sprite.size = CGSize(width: 96, height: 128)
        sprite.position = CGPoint()
        sprite.texture?.filteringMode = .Nearest
    }
    
    convenience init(position: CGPoint) {
        self.init()
        sprite.position = position
    }
    
}