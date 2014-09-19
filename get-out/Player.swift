//
//  Player.swift
//  get-out
//
//  Created by Cor Pruijs on 14-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class Player {
    
    enum Direction {
        case North
        case East
        case South
        case West
    }
    
    // the Sprite
    var sprite: SKSpriteNode
    let size: CGSize
    
    // Textures and Actions for animation
    var textureName: String
    let idleTexture = SKTexture(imageNamed: "player")
    let animationActionsFactory = AnimationActionsFactory()
    let walkingFramesActions: [Direction:SKAction]
    
    // speeds
    let slowDownMultiplier: CGFloat = 0.7
    let speedMultiplier: CGFloat = 3
    
    
    var currentDirection: Direction? = nil
    var currentAnimation: Direction? = nil
    
    init() {
        size = CGSize(width: 64, height: 64)
        textureName = "player_walk_south_1"
        
        //sprite configuration
        sprite = SKSpriteNode(imageNamed: textureName)
        sprite.texture?.filteringMode = .Nearest // fix for blurry pixel art
        sprite.size = size
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: size)
        
        idleTexture.filteringMode = .Nearest // fix for blurry pixel art
        walkingFramesActions = animationActionsFactory.getActions()
     
    }
    
    // Move the player to a Tile
    func moveToTile(tile: Tile) {
        println(tile.sprite.position.x)
        println(tile.sprite.position.y)
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
    
    // gets called aprox. 60 times per second by the GameScene
    func update(input: CGVector?) {
        
        move(vector: input)
        updateAnimation()
     
    }
    
    // returns an optional Direction value from a vector
    func directionfromVector(vector:CGVector) -> Direction? {
        
        let minimumSpeedForDirection: CGFloat = 5
        
        let dxPositive = vector.dx > 0
        let dyPositive = vector.dy > 0
        let dx = vector.dx
        let dy = vector.dy
        
        if !((dx > minimumSpeedForDirection || dx < -minimumSpeedForDirection) || (dy > minimumSpeedForDirection || dy < -minimumSpeedForDirection)) {
            return nil
        }
        
        if dyPositive {
            
            if dy > dx && dy > -dx {
                return .North
            }
        }
        if dxPositive {
            if dx > dy && dx > -dy {
                return .East
            }
        }
        if !dyPositive {
            if dy < dx && dy < -dx {
                return .South
            }
        }
        if !dxPositive {
            if dx < dy && dx < -dy {
                return .West
            }
        }
        
        println("ERROR, INVALID VECTOR AT DIRECTION FROM VECTOR")
        return nil
    }
    
    // moves the player by a vector, uses the speedMultiplier property
    func move(#vector: CGVector?) {
        if vector != nil {
            sprite.physicsBody?.velocity.dx = vector!.dx * speedMultiplier
            sprite.physicsBody?.velocity.dy = vector!.dy * speedMultiplier
        } else {
            sprite.physicsBody?.velocity.dx *= slowDownMultiplier
            sprite.physicsBody?.velocity.dy *= slowDownMultiplier
        }
    }
    
    
    
}