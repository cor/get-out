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
    let joystick = SKSpriteNode(imageNamed: "joystick")
    let mapSize = CGSize(width: 5, height: 5)
    
    var joystickVector = CGVector(dx: 0, dy: 0)
    let joystickVectorMultiplier = 0.1
    
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        addTiles()
        self.addChild(player.sprite)
        
        joystick.size = CGSize(width: 128, height: 128)
        joystick.position = CGPoint(x: joystick.size.width + 32, y: joystick.size.height / 2 + 16)
        joystick.texture?.filteringMode = .Nearest
        self.addChild(joystick)
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
            let dx = touchLocation.x - joystick.position.x
            let dy = touchLocation.y - joystick.position.y
            joystickVector.dx = dx
            joystickVector.dy = dy
        }
    }
    
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let touchLocation = touch.locationInNode!(self)
            let dx = touchLocation.x - joystick.position.x
            let dy = touchLocation.y - joystick.position.y
            joystickVector.dx = dx
            joystickVector.dy = dy
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        joystickVector = CGVector(dx: 0, dy: 0)
    }
    
    override func update(currentTime: CFTimeInterval) {
        println("dx: \(joystickVector.dx) dy: \(joystickVector.dy) ")
        let dx = joystickVector.dx * CGFloat(joystickVectorMultiplier)
        let dy = joystickVector.dy * CGFloat(joystickVectorMultiplier)
        let moveAction =  SKAction.moveByX(dx, y: dy, duration: 0.1)
        player.sprite.runAction(moveAction)
    }
}
