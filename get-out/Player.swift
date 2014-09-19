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
    
    var sprite: SKSpriteNode
    
    var gridPosition: CGPoint
    var textureName: String
    var currentDirection: Direction? = nil
    var currentAnimation: Direction? = nil
    
    let idleTexture = SKTexture(imageNamed: "player")
    var walkingFramesAtlas = SKTextureAtlas(named: "WalkImages")
    
    var walkingFrames: [Direction:[SKTexture]] = [:]
    var walkingFramesActions: [Direction:SKAction] = [:]
    
    let size: CGSize
    let slowDownMultiplier: CGFloat = 0.7
    
    
    init() {
        gridPosition = CGPoint(x: 0, y: 0)
        size = CGSize(width: 64, height: 64)
        textureName = "player_walk_south_1"
        
        sprite = SKSpriteNode(imageNamed: textureName)
        sprite.texture?.filteringMode = .Nearest
        sprite.size = size
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: size)
        
        idleTexture.filteringMode = .Nearest
        
        importWalkingFrames()
        createActionsFromFrames()
    }
    
    func moveToTile(tile: Tile) {
        println(tile.sprite.position.x)
        println(tile.sprite.position.y)
        let newX = tile.sprite.position.x + self.size.width / 2
        let newY = tile.sprite.position.y + self.size.height / 2
        let newLocation = CGPoint(x: newX, y: newY)
        let moveAction = SKAction.moveTo(newLocation, duration: 1)
        sprite.runAction(moveAction)
    }
    
    //import walking frames from WalkImages.atlas and put them in the walkingFrames Dictionary
    private func importWalkingFrames() {
        var tempWalkingFrames: [SKTexture] = []
        let imagesCount = walkingFramesAtlas.textureNames.count / 2
        for index in 1...imagesCount {
            let textureName = "player_walk_south_\(index)"
            let tempTexture = walkingFramesAtlas.textureNamed(textureName)
            tempWalkingFrames.append(tempTexture)
        }
        self.walkingFrames[.South] = tempWalkingFrames
        
        tempWalkingFrames = []
        for index in 1...imagesCount {
            let textureName = "player_walk_north_\(index)"
            let tempTexture = walkingFramesAtlas.textureNamed(textureName)
            tempWalkingFrames.append(tempTexture)
        }
        self.walkingFrames[.North] = tempWalkingFrames
   
    }
    
    //create SKAction animations from the walkingFrames Dictionary and put them in the walkingFramesActions Dictionary
    private func createActionsFromFrames() {
        let directionList = [Direction.North, Direction.South]
        
        for direction in directionList {
            let animateAction = SKAction.animateWithTextures(walkingFrames[direction]!, timePerFrame: 0.1, resize: false, restore: true)
            let repeatedAction = SKAction.repeatActionForever(animateAction)
            walkingFramesActions[direction] = repeatedAction
        }
        
    }
    
    private func updateAnimation() {
    
        func stopAnimation() {
            sprite.removeActionForKey("playerMoving")
            sprite.texture = idleTexture
        }
        
        let velocity = sprite.physicsBody?.velocity
        let direction = directionfromVector(velocity!)
        
        if direction != currentAnimation {
            if direction != nil {
                switch direction! {
                case .North:
                    println("north")
                    sprite.runAction(self.walkingFramesActions[.North]!, withKey: "playerMoving")
                case .East:
                    println("east")
                    stopAnimation()
                case .South:
                    println("south")
                    sprite.runAction(self.walkingFramesActions[.South]!, withKey: "playerMoving")
                case .West:
                    println("west")
                    stopAnimation()
                }
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
     
    }
    
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
    
    func move(#vector: CGVector?) {
        if vector != nil {
            sprite.physicsBody?.velocity.dx = vector!.dx
            sprite.physicsBody?.velocity.dy = vector!.dy
        } else {
            sprite.physicsBody?.velocity.dx *= slowDownMultiplier
            sprite.physicsBody?.velocity.dy *= slowDownMultiplier
        }
    }
    
    
    
}