//
//  Tile.swift
//  get-out
//
//  Created by Cor Pruijs on 14-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class Tile {
    
    var sprite: SKSpriteNode
    
    var gridPosition: GridPoint
    var textureName: String
    
    let size: CGSize
    
    init() {
        gridPosition = GridPoint(x: 0, y: 0)
        size = CGSize(width: 64, height: 64)
        textureName = "tile_floor"
        
        sprite = SKSpriteNode()
        sprite.size = size
        sprite.anchorPoint = CGPoint(x: 0, y: 0)
        
        updatePosition()
        updateTexture()
    }
    
    convenience init(gridPosition: GridPoint){
        self.init()
        self.gridPosition = gridPosition
        updatePosition()
    }
    
    convenience init(textureName: String) {
        self.init()
        self.textureName = textureName
        updateTexture()
    }
    
    convenience init(textureName: String, gridPosition: GridPoint) {
        self.init()
        self.textureName = textureName
        self.gridPosition = gridPosition
        updateTexture()
        updatePosition()
    }
    
    // TODO: Fix this Initializer
    convenience init(textureName: String, gridPosition: GridPoint, collides: Bool) {
        self.init(textureName: textureName, gridPosition: gridPosition)
        if collides {
            self.enableCollisions()
        }
    }
    
    // Add a PhysicsBody to the sprite in order to use collisions.
    func enableCollisions() {
        
        // Anchor point adjustments
        let newX = CGFloat(0.5 * self.size.width)
        let newY = CGFloat(0.5 * self.size.height)
        let center = CGPoint(x: newX, y: newY)
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: sprite.size, center: center)
        sprite.physicsBody?.dynamic = false
        
    }
    
    // Update actual position to represent grid position
    func updatePosition() {
        let newX = CGFloat(gridPosition.x) * size.width
        let newY = CGFloat(gridPosition.y) * size.height
        let newPosition = CGPoint(x: newX, y: newY)
        sprite.position = newPosition
    }
    
    // Update actual image to represent imageName
    func updateTexture() {
        sprite.texture = SKTexture(imageNamed: textureName)
        sprite.texture?.filteringMode = SKTextureFilteringMode.Nearest
    }
    
}

