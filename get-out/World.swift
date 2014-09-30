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
    private let mapSize = CGSize(width: 10, height: 10)
    let sprite: SKSpriteNode
    let camera = Camera()
    let player: Player
    
    init() {
        sprite = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: mapSize.width * 64, height: mapSize.height * 64))
        sprite.anchorPoint = CGPoint(x:0, y:0)
        sprite.zPosition = -100
        
        sprite.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.sprite.frame)
        
        player = Player(position: CGPoint(x: sprite.size.width / 2, y: sprite.size.height / 2))
        addTiles()
        
        sprite.addChild(player.sprite)
        sprite.addChild(camera.sprite)
    }
    
    private func addTiles() {
        
        // Create new tiles and add them to the tiles array
        for horizontalTileRow in 0..<Int(self.mapSize.height) {
            
            for verticalTileRow in 0..<Int(self.mapSize.width) {
                
                let position = GridPoint(x: verticalTileRow, y: horizontalTileRow)
                let tile = Tile(textureName: "tile_floor", gridPosition: position)
                tiles.append(tile)
            }
            
        }
        
        // Add tiles from the tiles array to the scene
        for tile in tiles {
            tile.sprite.zPosition = 10
            self.sprite.addChild(tile.sprite)
        }
        
    }
    
    // return optional tile from x y coord
    func getTile(#x: Int, y: Int) -> Tile? {
        let possibleTileIndex = (y * Int(mapSize.width)) + x
        
        if !(possibleTileIndex < 0 || possibleTileIndex > (tiles.count - 1)) {
            return tiles[possibleTileIndex]
        } else {
            return nil
        }
    }
    
    //return optional tile from gridPoint
    func getTile(#gridPoint: CGPoint) -> Tile? {
        let possibleTileIndex = (Int(gridPoint.y) * Int(mapSize.width)) + Int(gridPoint.x)
        if !(possibleTileIndex < 0 || possibleTileIndex > (tiles.count - 1)) {
            return tiles[possibleTileIndex]
        }
        else {
            return nil
        }
    }
    func update(joystickVector: CGVector?) {
        player.update(joystickVector)
        camera.sprite.position = player.sprite.position
        camera.centerOnNode(camera.sprite)
        
        func changeTextureUnderPlayer() {
            if let tile = getTile(gridPoint: player.currentGridPosition) {
            
                if let currentTile = player.currentTile {
                    
                    if tile !== player.currentTile! {
                        currentTile.sprite.texture = SKTexture(imageNamed: "tile_floor")
                        currentTile.sprite.texture?.filteringMode = .Nearest
                        tile.sprite.texture = SKTexture(imageNamed: "tile_floor_selected")
                        tile.sprite.texture?.filteringMode = .Nearest
                        player.currentTile = tile
                    }
                }
            }
        }
        
        changeTextureUnderPlayer()
    }
}
