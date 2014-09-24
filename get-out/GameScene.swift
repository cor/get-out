//
//  GameScene.swift
//  get-out
//
//  Created by Cor Pruijs on 06-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    var joystick = Joystick()
    let world = World()
    
    
    override func didMoveToView(view: SKView) {
        
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        joystick = Joystick(position: CGPoint(x: 0, y: -164))
        joystick.sprite.zPosition = 9000
        
        self.addChild(joystick.sprite)
        self.addChild(world.sprite)
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            let touchLocation = touch.locationInNode!(self)
            joystick.updateVector(touchLocation)

        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let touchLocation = touch.locationInNode!(self)
            joystick.updateVector(touchLocation)
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        joystick.updateVector(nil)
    }
    
    override func update(currentTime: CFTimeInterval) {
        world.update(joystick.vector)
    }
    
}
