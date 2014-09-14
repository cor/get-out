//
//  Player.swift
//  get-out
//
//  Created by Cor Pruijs on 14-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class Player {
    
    var sprite: SKSpriteNode
    
    var gridPosition: CGPoint
    var textureName: String
    
    let size: CGSize
    
    init() {
        gridPosition = CGPoint(x: 0, y: 0)
        size = CGSize(width: 64, height: 64)
        textureName = "character"
        
        sprite = SKSpriteNode(imageNamed: textureName)
        sprite.texture?.filteringMode = .Nearest
        sprite.size = size
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: size)
    }
    
    func moveToTile(tile: Tile) {
        println(tile.sprite.position.x)
        println(tile.sprite.position.y)
        let newX = tile.sprite.position.x + self.size.width / 2
        let newY = tile.sprite.position.y + self.size.height / 2
        let newLocation = CGPoint(x: newX, y: newY)
        let moveAction = SKAction.moveTo(newLocation, duration: 1)
        sprite.runAction(moveAction)
    }
}