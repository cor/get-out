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
    let centerRadius: CGFloat = 10
    
    init() {
        sprite = SKSpriteNode(imageNamed: "joystick")
        sprite.size = CGSize(width: 128, height: 128)
        sprite.position = CGPoint()
        sprite.texture?.filteringMode = .Nearest
    }
    
    convenience init(position: CGPoint) {
        self.init()
        sprite.position = position
    }

    func updateVector(touchLocation: CGPoint?) {
        if touchLocation != nil {
            let dx = (touchLocation!.x - sprite.position.x)
            let dy = (touchLocation!.y - sprite.position.y)
            vector = CGVector(
                dx: (dx > +centerRadius || dx < -centerRadius ? dx * vectorMultiplier : 0),
                dy: (dy > +centerRadius || dy < -centerRadius ? dy * vectorMultiplier : 0)
            )
        } else {
            vector = CGVector(dx: 0, dy: 0)
        }
    }
}