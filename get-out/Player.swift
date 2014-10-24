//
//  Player.swift
//  get-out
//
//  Created by Cor Pruijs on 14-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class Player {
    
    
    // the Sprite
    var sprite: SKSpriteNode
    let size: CGSize
    
    // MARK: Textures and animations
    var textureName: String
    let idleTexture = SKTexture(imageNamed: "player")
    let animationActionsFactory = AnimationActionsFactory()
    let walkingFramesActions: [Direction:SKAction]
    
    // MARK: Speed values
    let slowDownMultiplier: CGFloat = 0.7
    let speedMultiplier: CGFloat = 3
    var slowDownEnabled: Bool = true
    
    // MARK: current values
    var currentGridPosition: CGPoint
    var currentTile: Tile?
    var currentDirection: Direction? = nil
    var currentAnimation: Direction? = nil
    
    // stats
    var isAlive: Bool = true
    
    // MARK: Initializers
    
    init() {
        size = CGSize(width: 64, height: 64)
        textureName = "player_walk_south_1"
        
        currentGridPosition = CGPoint()
        currentTile = Tile()
        
        //sprite configuration
        sprite = SKSpriteNode(imageNamed: textureName)
        sprite.texture?.filteringMode = .Nearest // fix for blurry pixel art
        sprite.size = size
        sprite.zPosition = 100
        
//        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: size)
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: 32)
        sprite.physicsBody?.allowsRotation = false
    
        
        
        idleTexture.filteringMode = .Nearest // fix for blurry pixel art
        walkingFramesActions = animationActionsFactory.getActions()
     
    }
    
    convenience init(position: CGPoint) {
        self.init()
        sprite.position = position
    }
    
    // Move the player to a Tile
    func moveToTile(tile: Tile) {
        let newX = tile.sprite.position.x + self.size.width / 2
        let newY = tile.sprite.position.y + self.size.height / 2
        let newLocation = CGPoint(x: newX, y: newY)
        let moveAction = SKAction.moveTo(newLocation, duration: 1)
        sprite.runAction(moveAction)
    }
    
    //Update Sprite to use the corerct animation from walkingFramesActions[:]
    private func updateAnimation() {
    
        func stopAnimation() {
            sprite.removeActionForKey("playerMoving")
            sprite.texture = idleTexture
        }
        
        let velocity = sprite.physicsBody?.velocity
        let direction = directionfromVector(velocity!)
        
        if direction != currentAnimation {
            if direction != nil {
                sprite.runAction(self.walkingFramesActions[direction!]!, withKey: "playerMoving")
                currentAnimation = direction
            }
            else {
                currentAnimation = nil
                stopAnimation()
            }
        }
        
    }
    
    func update(input: CGVector?) {
        
        move(vector: input)
        updateAnimation()
        updateCurrentGridPosition()
     
    }
    
    // moves the player by a vector, uses the speedMultiplier property
    func move(#vector: CGVector?) {
        if vector != nil {
            sprite.physicsBody?.velocity.dx = vector!.dx * speedMultiplier
            sprite.physicsBody?.velocity.dy = vector!.dy * speedMultiplier
        } else {
            if slowDownEnabled {
                sprite.physicsBody?.velocity.dx *= slowDownMultiplier
                sprite.physicsBody?.velocity.dy *= slowDownMultiplier
            }
        }
    }
    
    private func updateCurrentGridPosition() {
        var position = sprite.position
        
        // adjust position to represent feet
        position.x += 64
        position.y += 32
    
        var gridPoint = CGPoint(x: Int(position.x / 64) - 1, y: Int(position.y / 64) - 1)
        
        currentGridPosition = gridPoint
    }
    
}