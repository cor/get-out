//
//  Weapon.swift
//  get-out
//
//  Created by Cor Pruijs on 23-10-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit


class Weapon {
    
    let sprite = SKSpriteNode()
    
    func shoot(#direction: CGVector) {
        
        let bullet = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 2, height: 4))
        bullet.position = sprite.parent!.position
        bullet.zPosition = 100
        bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size)
        bullet.physicsBody?.velocity = direction
        
        let waitAction = SKAction.waitForDuration(5)
        let removeAction = SKAction.removeFromParent()
        let actionSecquence = SKAction.sequence([waitAction, removeAction])
        
        bullet.runAction(actionSecquence)
        sprite.parent?.parent?.addChild(bullet)
        println(sprite.parent?.parent?)
        
    }
}

