//
//  AnimationActionsFactory.swift
//  get-out
//
//  Created by Cor Pruijs on 19-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit


// class that generates animation SKActions at initialization and exports them using getActions()
class AnimationActionsFactory {
    var walkingFramesAtlas = SKTextureAtlas(named: "WalkImages")
    var walkingFrames: [Direction:[SKTexture]] = [:]
    var walkingFramesActions: [Direction:SKAction] = [:]
    init() {
        importWalkingFrames()
        createActionsFromFrames()
    }
    
    private func importWalkingFrames() {
        
        var tempWalkingFrames: [SKTexture] = []
        let imagesCount = walkingFramesAtlas.textureNames.count / 3
        
        for index in 1...imagesCount {
            let textureName = "player_walk_north_\(index)"
            let tempTexture = walkingFramesAtlas.textureNamed(textureName)
            tempWalkingFrames.append(tempTexture)
        }
        self.walkingFrames[Direction.North] = tempWalkingFrames
        
        
        tempWalkingFrames = []
        for index in 1...imagesCount {
            let textureName = "player_walk_east_\(index)"
            let tempTexture = walkingFramesAtlas.textureNamed(textureName)
            tempWalkingFrames.append(tempTexture)
        }
        self.walkingFrames[Direction.East] = tempWalkingFrames
        
    
        tempWalkingFrames = []
        for index in 1...imagesCount {
            let textureName = "player_walk_south_\(index)"
            let tempTexture = walkingFramesAtlas.textureNamed(textureName)
            tempWalkingFrames.append(tempTexture)
        }
        self.walkingFrames[Direction.South] = tempWalkingFrames
        
        
        tempWalkingFrames = []
        for index in 1...imagesCount {
            let textureName = "player_walk_west_\(index)"
            let tempTexture = walkingFramesAtlas.textureNamed(textureName)
            tempWalkingFrames.append(tempTexture)
        }
        self.walkingFrames[Direction.West] = tempWalkingFrames
    }
    
    
    //create SKAction animations from the walkingFrames Dictionary and put them in the walkingFramesActions Dictionary
    private func createActionsFromFrames() {
        
        // All Direction values that have animations
        let directionList = [Direction.North, Direction.East, Direction.South, Direction.West]
        
        for direction in directionList {
            let animateAction = SKAction.animateWithTextures(walkingFrames[direction]!, timePerFrame: 0.1, resize: false, restore: true)
            let repeatedAction = SKAction.repeatActionForever(animateAction)
            walkingFramesActions[direction] = repeatedAction
        }
        
    }
    
    func getActions() -> [Direction:SKAction] {
        return walkingFramesActions
    }
}