//
//  GameScene.swift
//  get-out
//
//  Created by Cor Pruijs on 06-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let world = World()
    
    var joystickMove = Joystick()
    var joystickShoot = Joystick()
    var debugOverlay = DebugOverlay()
    
    
    override func didMoveToView(view: SKView) {
        
        //view settings
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        //world
        world.setTile(gridPoint: GridPoint(x: 3,y: 3), tile: Tile(tileDefinition: world.tileFactory.tileDefinitions["wall"]!, gridPosition: GridPoint(x: 3, y: 3)))
        world.setTile(gridPoint: GridPoint(x: 4,y: 3), tile: Tile(tileDefinition: world.tileFactory.tileDefinitions["wall"]!, gridPosition: GridPoint(x: 4, y: 3)))
        world.setTile(gridPoint: GridPoint(x: 5,y: 3), tile: Tile(tileDefinition: world.tileFactory.tileDefinitions["wall"]!, gridPosition: GridPoint(x: 5, y: 3)))
        world.setTile(gridPoint: GridPoint(x: 5,y: 4), tile: Tile(tileDefinition: world.tileFactory.tileDefinitions["wall"]!, gridPosition: GridPoint(x: 5, y: 4)))
        self.physicsWorld.contactDelegate = world
        self.addChild(world)
        
        //debug overlay
        debugOverlay = DebugOverlay(size: self.frame.size)
        self.addChild(debugOverlay.sprite)
        debugOverlay.toggle()
        
        //joystick move
        let joystickMovePosition = CGPoint(x: -(self.size.width / 2) + (joystickMove.size.width / 2), y: -(self.size.height / 2) + (joystickMove.size.height / 2) )
        joystickMove = Joystick(imageNamed: "joystick_move", position: joystickMovePosition, name: "joystickMove")
        self.addChild(joystickMove)
        
        //joystick shoot
        let joystickShootPosition = CGPoint(x: +(self.size.width / 2) - (joystickShoot.size.width / 2), y: -(self.size.height / 2) + (joystickMove.size.height / 2) )
        joystickShoot = Joystick(imageNamed: "joystick_shoot", position: joystickShootPosition, name: "joystickShoot")
        self.addChild(joystickShoot)
    }
    
    // MARK: input
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            
            let touchedLocation: CGPoint = touch.locationInNode(self)
            let touchedNode: SKNode = self.nodeAtPoint(touchedLocation)
            
            if touchedNode.name == "joystickMove" {
                joystickMove.startControl(touch as UITouch, location: touchedLocation)
            }
            
            if touchedNode.name == "joystickShoot" {
                joystickShoot.startControl(touch as UITouch, location: touchedLocation)
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
            
            // update joysticks
            if touch as? UITouch == joystickMove.startTouch {
                let touchLocation = touch.locationInNode!(self)
                joystickMove.updateControl(touchLocation)
            }
            
            if touch as? UITouch == joystickShoot.startTouch {
                let touchLocation = touch.locationInNode!(self)
                joystickShoot.updateControl(touchLocation)
            }
            
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            // update joysticks
            if touch as? UITouch == joystickMove.startTouch {
                joystickMove.endControl()
            }
            
            if touch as? UITouch == joystickShoot.startTouch {
                joystickShoot.endControl()
            }
        }
    }
   
    
    override func update(currentTime: CFTimeInterval) {
        
        
        self.updateDebugLabels()
        world.update()
        world.player.update(inputMove: joystickMove.vector, inputShoot: joystickShoot.vector)
        
    }
    
 
    // FIXME:
    func updateDebugLabels() {
        for label in debugOverlay.debugLabels {
            label.update("\(world.player.position.x)")
            
            switch label.name {
            case "x":
                label.update("\(Int(world.player.position.x))")
            case "y":
                label.update("\(Int(world.player.position.y))")
            case "player alive":
                label.update("\(world.player.isAlive)")
            default:
                println("invalid label name, by the way you should remove this dumb for-switch combination")
            }
        }
    }
}
