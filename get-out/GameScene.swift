//
//  GameScene.swift
//  get-out
//
//  Created by Cor Pruijs on 06-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    var testTile = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 100, height: 100))
    
    override func didMoveToView(view: SKView) {
        println(self.size)
        println(self.frame.size)
        testTile.position = CGPoint(x: 100, y: 100)
        testTile.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.addChild(testTile)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            let touchLocation = touch.locationInNode!(self)
            println(touchLocation)
            
            testTile.position = touchLocation
        }
    }
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let touchLocation = touch.locationInNode(self)
            testTile.position = touchLocation
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
}
