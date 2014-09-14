//
//  Joystick.swift
//  get-out
//
//  Created by Cor Pruijs on 14-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class Joystick {
    
    let sprite: SKSpriteNode
    var vector = CGVector(dx: 0, dy: 0)
    let vectorMultiplier: CGFloat = 0.1
    
    init() {
        sprite = SKSpriteNode(imageNamed: "joystick")
        sprite.size = CGSize(width: 128, height: 128)
        sprite.position = CGPoint(x: sprite.size.width + 32, y: sprite.size.height / 2 + 16)
        sprite.texture?.filteringMode = .Nearest
    }
    
    convenience init(position: CGPoint) {
        self.init()
        sprite.position = position
    }
    
    func updateVector(touchLocation: CGPoint?) {
        if touchLocation != nil {
            let dx = (touchLocation!.x - sprite.position.x) * vectorMultiplier
            let dy = (touchLocation!.y - sprite.position.y) * vectorMultiplier
            vector = CGVector(dx: dx, dy: dy)
        } else {
            vector = CGVector(dx: 0, dy: 0)
        }
    }
}