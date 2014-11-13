//
//  Healthbar.swift
//  get-out
//
//  Created by Cor Pruijs on 30-10-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class HealthBar: SubclassNode {
    
    // the inner part of the healthbar, that displays the amount of health left
    private let progressNode = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 200, height: 20))
    
    override init() {
        // TODO
        super.init(texture: nil, color: UIColor.blackColor(), size: CGSize(width: 204, height: 24) )
        
        // set the anchorpoint to the top left corner, since it will be there in the screen
        anchorPoint = CGPoint(x: 0, y: 1)
        
        
        // progressnode setup
        progressNode.anchorPoint = CGPoint(x: 0, y: 1)
        progressNode.position = CGPoint(x: 2, y: -2)
        addChild(progressNode)
        
    }
}
