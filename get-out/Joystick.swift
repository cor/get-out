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
    var vector: CGVector? = nil
    let vectorMultiplier: CGFloat = 1
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
            
            let maxDx = sprite.size.width / 2
            let maxDy = sprite.size.height / 2
            
            // if the vector is too big (IE, pressed outside sprite), change vector to nil
            if (dx > +maxDx || dx < -maxDx || dy > +maxDy || dy < -maxDy) {
               vector = nil
            }
            else {
                vector = CGVector(
                    dx: (dx > +centerRadius || dx < -centerRadius ? dx * vectorMultiplier : 0),
                    dy: (dy > +centerRadius || dy < -centerRadius ? dy * vectorMultiplier : 0)
                )
            }
            
        } else {
            vector = nil
        }
    }
}