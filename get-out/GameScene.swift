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
    let player = Player()
    var joystick: Joystick = Joystick()
    let mapSize = CGSize(width: 5, height: 5)
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        addTiles()
        joystick = Joystick(position: CGPoint(x: 160, y: 80))
        self.addChild(joystick.sprite)
        player.moveToTile(getTile(x: 2, y: 2))
        self.addChild(player.sprite)
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
    
    func getTile(#x: Int, y: Int) -> Tile {
       return tiles[(y * Int(mapSize.width)) + x]
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            let touchLocation = touch.locationInNode!(self)
            joystick.updateVector(touchLocation)

        }
    }
    
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let touchLocation = touch.locationInNode!(self)
            joystick.updateVector(touchLocation)
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        joystick.updateVector(nil)
    }
    
    override func update(currentTime: CFTimeInterval) {
        player.update(joystick.vector)
    }
}
