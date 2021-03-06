//
//  World.swift
//  get-out
//
//  Created by Cor Pruijs on 23-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class World: SubclassNode, SKPhysicsContactDelegate  {
    
    // MARK: Private properties
    private var tiles: [Tile] = []
    private let mapSize = CGSize(width: 10, height: 10)
    
    // MARK: Public properties
    let tileFactory = TileFactory()
    let camera = Camera()
    let player: Player
    
    let enemy: Enemy
    
    // MARK: Initialization
    override init() {
        
        
        player = Player()
        enemy = Enemy(position: CGPoint(x: 64, y: 64))
        super.init(texture: nil, color: UIColor.redColor(), size: CGSize(width: mapSize.width * 64, height: mapSize.height * 64))
        
        //world setup
        name = "world"
        
        player.position = CGPoint(x: size.width / 2, y: size.height / 2)
        anchorPoint = CGPoint(x:0, y:0)
        zPosition = -100
        physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
        
        addTiles()
        addChild(player)
        addChild(camera)
        addChild(enemy)
        
        
    }
    
    // load level from text file
    convenience init(fileNamed fileName: String) {
        self.init()
        
        // delete default tiles
        for tile in tiles {
            tile.removeFromParent()
        }
        tiles = []
        
        
        // FIXME
        if let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt") {
            
            if let testString = String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: nil) {
                
                // split lines of level
                let stringArray = testString.componentsSeparatedByString("\n")
                
                var lineIndex = 0
                
                for var index = stringArray.count - 1; index >= 0; index-- {
                
                    var indexInLine = 0
                    
                    for character in stringArray[index] {
                        
                        let position = GridPoint(x: indexInLine, y: lineIndex)
                        if character == "O" {
                            let tile = Tile(tileDefinition: tileFactory.tileDefinitions["floor"]!, gridPosition: position)
                            tiles.append(tile)
                        } else if character == "X" {
                            let tile = Tile(tileDefinition: tileFactory.tileDefinitions["wall"]!, gridPosition: position)
                            tiles.append(tile)
                        }
                        
                        ++indexInLine
                        
                    }
                    
                    ++lineIndex
                }
                
            }
        }
        // Add tiles from the tiles array to the scene
        for tile in tiles {
            tile.zPosition = 10
            addChild(tile)
        }
        
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
            tile.zPosition = 10
            addChild(tile)
        }
        
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        let bodyAName:String = contact.bodyA.node!.name!
        let bodyBName:String = contact.bodyB.node!.name!
        
        if bodyAName == "player" && bodyBName == "enemy" {
            player.health--
        }
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
            tiles[possibleTileIndex].removeFromParent()
            tiles[possibleTileIndex] = tile
            addChild(tiles[possibleTileIndex])
        }
    }
    
    func update() {
        camera.position = player.position
        camera.centerOnNode(camera)
        
    }
}
