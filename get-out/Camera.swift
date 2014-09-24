//
//  Camera.swift
//  get-out
//
//  Created by Cor Pruijs on 23-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class Camera {
    let sprite = SKNode.node()
    
    init() {
        sprite.name = "camera"
    }
    
    func centerOnNode(node: SKNode) {
        
        let cameraPositionInScene: CGPoint = sprite.scene!.convertPoint(sprite.position, fromNode: sprite.parent!)
        let newPositoin = CGPoint(x: sprite.parent!.position.x - cameraPositionInScene.x, y: sprite.parent!.position.y - cameraPositionInScene.y)
        let action = SKAction.moveTo(newPositoin, duration: 0.2)
        action.timingMode = SKActionTimingMode.EaseOut
        
        sprite.parent!.runAction(action)
    }
}