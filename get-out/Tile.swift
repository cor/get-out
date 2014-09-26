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
    
    var gridPosition: CGPoint
    var textureName: String
    
    let size: CGSize
    
    init() {
        gridPosition = CGPoint(x: 0, y: 0)
        size = CGSize(width: 64, height: 64)
        textureName = "tile_floor"
        
        sprite = SKSpriteNode()
        sprite.size = size
        sprite.anchorPoint = CGPoint(x: 0, y: 0)
        
        updatePosition()
        updateTexture()
    }
    
    convenience init(gridPosition: CGPoint){
        self.init()
        self.gridPosition = gridPosition
        updatePosition()
    }
    
    convenience init(textureName: String) {
        self.init()
        self.textureName = textureName
        updateTexture()
    }
    
    convenience init(textureName: String, gridPosition: CGPoint) {
        self.init()
        self.textureName = textureName
        self.gridPosition = gridPosition
        updateTexture()
        updatePosition()
    }
    
    // Update actual position to represent grid position
    func updatePosition() {
        let newX = gridPosition.x * size.width
        let newY = gridPosition.y * size.height
        let newPosition = CGPoint(x: newX, y: newY)
        sprite.position = newPosition
    }
    
    // Update actual image to represent imageName
    func updateTexture() {
        sprite.texture = SKTexture(imageNamed: textureName)
        sprite.texture?.filteringMode = SKTextureFilteringMode.Nearest
    }
    
}

