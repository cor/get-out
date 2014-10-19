//
//  GameScene.swift
//  get-out
//
//  Created by Cor Pruijs on 06-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    let world = World()
    
    var joystick = Joystick()
    var debugOverlay = DebugOverlay()
    
    
    override func didMoveToView(view: SKView) {
        
        //view settings
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        //world
        world.setTile(gridPoint: GridPoint(x: 3,y: 3), tile: Tile(tileDefinition: world.tileFactory.tileDefinitions["wall"]!, gridPosition: GridPoint(x: 3, y: 3)))
        self.addChild(world.sprite)
        
        //debug overlay
        debugOverlay = DebugOverlay(size: self.frame.size)
        self.addChild(debugOverlay.sprite)
        debugOverlay.toggle()
        
        //joystick
        
        let newPosition = CGPoint(x: -(self.size.width / 2) + (joystick.sprite.size.width / 2), y: -(self.size.height / 2) + (joystick.sprite.size.height / 2) )
        joystick = Joystick(position: newPosition )
        self.addChild(joystick.sprite)
    }
    
    // MARK: input
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            
            let touchedLocation: CGPoint = touch.locationInNode(self)
            let touchedNode: SKNode = self.nodeAtPoint(touchedLocation)
            
            if touchedNode.name == "joystick" {
                joystick.startControl(touch as UITouch, location: touchedLocation)
                
            }
        }
        
        //toggle debugoverlay if three fingers are pressed at the top of the screen
        if touches.count == 3 {
            
            var goingToEnable = true
            
            for touch: AnyObject in touches {
                let touchLocation = touch.locationInNode!(self)
                if touchLocation.y < ( self.size.height / 2) - ( debugOverlay.background.size.height) {
                    goingToEnable = false
                }
            }
            
            if goingToEnable {
                debugOverlay.toggle()
            }
        }
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            // update joystick
            if touch as? UITouch == joystick.startTouch {
                let touchLocation = touch.locationInNode!(self)
                joystick.updateControl(touchLocation)
            }
            
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            // update joystick
            if touch as? UITouch == joystick.startTouch {
                joystick.endControl()
            }
        }
    }
   
    
    override func update(currentTime: CFTimeInterval) {
        
        
        self.updateDebugLabels()
        world.update()
        world.player.update(joystick.vector)
        
    }
    
 
    // FIXME:
    func updateDebugLabels() {
        for label in debugOverlay.debugLabels {
            label.update("\(world.player.sprite.position.x)")
            
            switch label.name {
            case "x":
                label.update("\(Int(world.player.sprite.position.x))")
            case "y":
                label.update("\(Int(world.player.sprite.position.y))")
            case "player alive":
                label.update("\(world.player.isAlive)")
            default:
                println("invalid label name, by the way you should remove this dumb for-switch combination")
            }
        }
    }
}
