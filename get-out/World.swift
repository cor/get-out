//
//  World.swift
//  get-out
//
//  Created by Cor Pruijs on 23-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class World: NSObject, SKPhysicsContactDelegate  {
    
    // MARK: Private properties
    private var tiles: [Tile] = []
    private let mapSize = CGSize(width: 10, height: 10)
    
    // MARK: Public properties
    let tileFactory = TileFactory()
    let sprite: SKSpriteNode
    let camera = Camera()
    let player: Player
    
    let enemy: Enemy
    
    // MARK: Initialization
    override init() {
        sprite = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: mapSize.width * 64, height: mapSize.height * 64))
        sprite.anchorPoint = CGPoint(x:0, y:0)
        sprite.zPosition = -100
        
        sprite.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.sprite.frame)
        
        player = Player(position: CGPoint(x: sprite.size.width / 2, y: sprite.size.height / 2))
        
        enemy = Enemy(position: CGPoint(x: 64, y: 64))
        
        super.init()
        addTiles()
        sprite.addChild(player)
        sprite.addChild(camera)
        sprite.addChild(enemy)
    }
    
    private func addTiles() {
        
        // Create new tiles and add them to the tiles array
        for horizontalTileRow in 0..<Int(self.mapSize.height) {
            
            for verticalTileRow in 0..<Int(self.mapSize.width) {
                
                let position = GridPoint(x: verticalTileRow, y: horizontalTileRow)
                let tile = Tile(tileDefinition: tileFactory.tileDefinitions["floor"]!, gridPosition: position)
                tiles.append(tile)
            }
            
        }
        
        // Add tiles from the tiles array to the scene
        for tile in tiles {
            tile.sprite.zPosition = 10
            self.sprite.addChild(tile.sprite)
        }
        
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        // TODO: handle contact
    }
    
    
    // MARK: Tile Interaction methods
    
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
    func getTile(#gridPoint: GridPoint) -> Tile? {
        let possibleTileIndex = gridPoint.y * Int(mapSize.width) + gridPoint.x
        if !(possibleTileIndex < 0 || possibleTileIndex > (tiles.count - 1)) {
            return tiles[possibleTileIndex]
        }
        else {
            return nil
        }
    }
    
    func setTile(#gridPoint: GridPoint, tile: Tile) {
        let possibleTileIndex = gridPoint.y * Int(mapSize.width) + Int(gridPoint.x)
        if !(possibleTileIndex < 0 || possibleTileIndex > (tiles.count - 1)) {
            tiles[possibleTileIndex].sprite.removeFromParent()
            tiles[possibleTileIndex] = tile
            sprite.addChild(tiles[possibleTileIndex].sprite)
        }
    }
    
    func update() {
        camera.position = player.position
        camera.centerOnNode(camera)
        
    }
}
