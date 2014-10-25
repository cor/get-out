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
    let positionAtDirection: [Direction : CGPoint] = [.North : CGPoint(x: 0, y: 32), .East : CGPoint(x: 32, y: 0), .South : CGPoint(x: 0, y: -32), .West : CGPoint(x: -32, y: 0)]
    let speedmultiplier: CGFloat = 10
    
    
    func shoot(#direction: CGVector) {
        
        let bullet = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 2, height: 2))
        
        if let bulletDirection = directionfromVector(direction) {
            if let boost = positionAtDirection[bulletDirection] {
                bullet.position.x = sprite.parent!.position.x + boost.x
                bullet.position.y = sprite.parent!.position.y + boost.y
            } else {
                println(" invalid boost value")
            }
        }
        
        bullet.zPosition = 100
        bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size)
        bullet.physicsBody?.mass *= 100
        bullet.physicsBody?.velocity = direction
        bullet.physicsBody?.velocity.dx *= speedmultiplier
        bullet.physicsBody?.velocity.dy *= speedmultiplier
        
        let waitAction = SKAction.waitForDuration(5)
        let removeAction = SKAction.removeFromParent()
        let actionSecquence = SKAction.sequence([waitAction, removeAction])
        
        bullet.runAction(actionSecquence)
        sprite.parent?.parent?.addChild(bullet)
        
    }
}

