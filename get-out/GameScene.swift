//
//  GameScene.swift
//  get-out
//
//  Created by Cor Pruijs on 06-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    var tiles: [Tile] = []
    
    override func didMoveToView(view: SKView) {
        tiles.append(Tile(gridPosition: CGPoint(x: 2, y: 2)))
        for tile in tiles {
            self.addChild(tile.sprite)
        }
        
    }
    
    
    
    
    
    
    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            let touchLocation = touch.locationInNode!(self)
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let touchLocation = touch.locationInNode(self)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
}
