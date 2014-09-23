//
//  World.swift
//  get-out
//
//  Created by Cor Pruijs on 23-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class World {
    
    private var tiles: [Tile] = []
    private let mapSize = CGSize(width: 5, height: 5)
    let sprite = SKNode.node()
    let camera = Camera()
    let player = Player()
    
    init() {
        addTiles()
        sprite.addChild(player.sprite)
        player.moveToTile(getTile(x: 2, y: 2))
        sprite.addChild(camera.sprite)
    }
    
    private func addTiles() {
        
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
            self.sprite.addChild(tile.sprite)
        }
        
    }
    
    func getTile(#x: Int, y: Int) -> Tile {
       return tiles[(y * Int(mapSize.width)) + x]
    }
    func update(joystickVector: CGVector?) {
        player.update(joystickVector)
        camera.sprite.position = player.sprite.position
    }
}
