//
//  Enemey.swift
//  get-out
//
//  Created by Cor Pruijs on 09-10-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class Enemy: SubclassNode {
    
    override init() {
        
        super.init(texture: nil, color: nil, size: CGSize())
        
        size = CGSize(width: 64, height: 64)
        texture = SKTexture(imageNamed: "enemy")
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = ColliderType.Enemy.rawValue
        physicsBody?.contactTestBitMask = ColliderType.Player.rawValue | ColliderType.Bullet.rawValue
        
        texture?.filteringMode = .Nearest
        zPosition = 100
    }
    
    convenience init(position: CGPoint) {
        self.init()
        self.position = position
    }
    
    // Move the Enemy to a Tile
    func moveToTile(tile: Tile) {
        let newX = tile.sprite.position.x + self.size.width / 2
        let newY = tile.sprite.position.y + self.size.height / 2
        let newLocation = CGPoint(x: newX, y: newY)
        let moveAction = SKAction.moveTo(newLocation, duration: 1)
        runAction(moveAction)
    }
}