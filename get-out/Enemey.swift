//
//  Enemey.swift
//  get-out
//
//  Created by Cor Pruijs on 09-10-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class Enemy {
    var sprite: SKSpriteNode
    let size: CGSize
    
    // MARK: Initializers
    
    init() {
        size = CGSize(width: 64, height: 64)
        sprite = SKSpriteNode(imageNamed: "enemy")
        sprite.size = size
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        sprite.physicsBody?.allowsRotation = false
        sprite.texture?.filteringMode = .Nearest
        sprite.zPosition = 100
    }
    
    convenience init(position: CGPoint) {
        self.init()
        sprite.position = position
    }
    
    // Move the Enemy to a Tile
    func moveToTile(tile: Tile) {
        let newX = tile.sprite.position.x + self.size.width / 2
        let newY = tile.sprite.position.y + self.size.height / 2
        let newLocation = CGPoint(x: newX, y: newY)
        let moveAction = SKAction.moveTo(newLocation, duration: 1)
        sprite.runAction(moveAction)
    }
}