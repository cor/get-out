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
    let mapSize = CGSize(width: 3, height: 2)
    
    override func didMoveToView(view: SKView) {
        addTiles()
    }
    
    func addTiles() {
        
        // Create new tiles and add them to the tiles array
        for horizontalTileRow in 0..<Int(self.mapSize.height) {
            for verticalTileRow in 0..<Int(self.mapSize.width) {
                let position = CGPoint(x: verticalTileRow, y: horizontalTileRow)
                let tile = Tile(textureName: "tile_floor", gridPosition: position)
                tiles.append(tile)
            }
        }
        
        // Add tiles from the tiles array to the scene
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
