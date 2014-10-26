//
//  Camera.swift
//  get-out
//
//  Created by Cor Pruijs on 23-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

//the scene will center on this node

class Camera: SubclassNode {
    
    func centerOnNode(node: SKNode) {
        
        let cameraPositionInScene: CGPoint = scene!.convertPoint(position, fromNode: parent!)
        let newPosition = CGPoint(x: parent!.position.x - cameraPositionInScene.x, y: parent!.position.y - cameraPositionInScene.y)
        
        // smooth camera movement using easings
        let action = SKAction.moveTo(newPosition, duration: 0.2)
        action.timingMode = SKActionTimingMode.EaseOut
        
        parent!.runAction(action)
    }
}