//
//  Weapon.swift
//  get-out
//
//  Created by Cor Pruijs on 23-10-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit


class Weapon: SubclassNode {
    
    let positionAtDirection: [Direction : CGPoint] = [.North : CGPoint(x: 0, y: 32), .East : CGPoint(x: 32, y: 0), .South : CGPoint(x: 0, y: -32), .West : CGPoint(x: -32, y: 0)]
    let speedmultiplier: CGFloat = 10
    let timeUntillDespawn: NSTimeInterval = 2
    let bulletAction: SKAction
    let shootDelay: NSTimeInterval = 0.2
    
    var previousTime = NSDate.timeIntervalSinceReferenceDate()
    
    
    override init() {
        
        // despawnAction
        let waitAction = SKAction.waitForDuration(timeUntillDespawn)
        let removeAction = SKAction.removeFromParent()
        bulletAction = SKAction.sequence([waitAction, removeAction])
        
        super.init(texture: nil, color: nil, size: CGSize())
    }
    
    func shoot(#direction: CGVector) {
        
        
        if NSDate.timeIntervalSinceReferenceDate() > previousTime + shootDelay {
        
            let bullet = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 2, height: 2))
            
            if let bulletDirection = directionfromVector(direction) {
                if let boost = positionAtDirection[bulletDirection] {
                    bullet.position.x = parent!.position.x + boost.x
                    bullet.position.y = parent!.position.y + boost.y
                }
            }
            
            bullet.zPosition = 100
            bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size)
            bullet.physicsBody?.mass *= 100
            bullet.physicsBody?.velocity = direction
            bullet.physicsBody?.velocity.dx *= speedmultiplier
            bullet.physicsBody?.velocity.dy *= speedmultiplier
            bullet.runAction(bulletAction)
            
            parent?.parent?.addChild(bullet)
            
            previousTime = NSDate.timeIntervalSinceReferenceDate()
        }
        
        
        
    }
}

