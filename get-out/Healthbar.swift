//
//  Healthbar.swift
//  get-out
//
//  Created by Cor Pruijs on 30-10-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class HealthBar: SKCropNode {
    
    private let progressNode = SKSpriteNode(imageNamed: "healthbar")
    let maxHealth = 100
    
    override init() {
        
        super.init()
        
        //sprite setup
        let maskNodez = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: 200, height: 20))
        maskNodez.anchorPoint = CGPoint(x: 0, y: 1)
        maskNode = maskNodez
        
        progressNode.anchorPoint = CGPoint(x: 0, y: 1)
        
        
        // progress bar
        self.addChild(progressNode)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProgress(health: Int) {
        
        
        // fixme
        let xScale: CGFloat = CGFloat((health / maxHealth) * 100)
        println(xScale)
        self.maskNode?.xScale = xScale
    }
}
