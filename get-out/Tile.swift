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
    var color: UIColor
    var size: CGSize
    
    init() {
        gridPosition = CGPoint(x: 0, y: 0)
        color = UIColor.redColor()
        size = CGSize(width: 64, height: 64)
        
        sprite = SKSpriteNode(color: color, size: size)
        sprite.anchorPoint = CGPoint(x: 0, y: 0)
        updatePosition()
    }
    
    convenience init(gridPosition: CGPoint){
        self.init()
        self.gridPosition = gridPosition
        updatePosition()
    }
    
    // Update actual position to represent grid position
    func updatePosition() {
        let newX = gridPosition.x * size.width
        let newY = gridPosition.y * size.height
        let newPosition = CGPoint(x: newX, y: newY)
        sprite.position = newPosition
    }
}