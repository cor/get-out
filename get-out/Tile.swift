//
//  Tile.swift
//  get-out
//
//  Created by Cor Pruijs on 14-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class Tile: SubclassNode {
    
    var gridPosition: GridPoint = GridPoint(x: 0, y: 0)
    var textureName: String = "tile_floor"
    
    
    // MARK: Public Initializers
    convenience init(tileDefinition: TileDefinition) {
        self.init(textureName: tileDefinition.textureName, collides: tileDefinition.collides)
    }
    
    convenience init(tileDefinition: TileDefinition, gridPosition: GridPoint) {
        self.init(tileDefinition: tileDefinition)
        self.gridPosition = gridPosition
        updatePosition()
    }
    
    //MARK: private initializers
    override init() {
        
        super.init(texture: nil, color: nil, size: CGSize())
        
        //sprite configuration
        name = "tile"
        size = CGSize(width: 64, height: 64)
        texture = SKTexture(imageNamed: textureName)
        texture?.filteringMode = .Nearest
        anchorPoint = CGPoint(x: 0, y: 0)
        
        //position
        gridPosition = GridPoint(x: 0, y: 0)
        
        
        updatePosition()
        updateTexture()
    }
    
    private convenience init(gridPosition: GridPoint){
        self.init()
        self.gridPosition = gridPosition
        updatePosition()
    }
    
    private convenience init(textureName: String) {
        self.init()
        self.textureName = textureName
        updateTexture()
    }
    
    private convenience init(textureName: String, collides: Bool) {
        self.init(textureName: textureName)
        if collides {
            self.enableCollisions()
        }
        
    }
    
    private convenience init(textureName: String, gridPosition: GridPoint) {
        self.init()
        self.textureName = textureName
        self.gridPosition = gridPosition
        updateTexture()
        updatePosition()
    }
    
    private convenience init(textureName: String, gridPosition: GridPoint, collides: Bool) {
        self.init(textureName: textureName, gridPosition: gridPosition)
        if collides {
            self.enableCollisions()
        }
    }
    
    //MARK: Update functions
    
    // Update actual position to represent grid position
    func updatePosition() {
        let newX = CGFloat(gridPosition.x) * size.width
        let newY = CGFloat(gridPosition.y) * size.height
        let newPosition = CGPoint(x: newX, y: newY)
        position = newPosition
    }
    
    // Update actual image to represent imageName
    func updateTexture() {
        texture = SKTexture(imageNamed: textureName)
        texture?.filteringMode = SKTextureFilteringMode.Nearest
    }
    
    
    // Add a PhysicsBody to the sprite in order to use collisions.
    func enableCollisions() {
        
        // Anchor point adjustments
        let newX = CGFloat(0.5 * self.size.width)
        let newY = CGFloat(0.5 * self.size.height)
        let center = CGPoint(x: newX, y: newY)
        
        physicsBody = SKPhysicsBody(rectangleOfSize: size, center: center)
        physicsBody?.dynamic = false
        
    }
}