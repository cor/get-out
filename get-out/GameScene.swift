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
    var debugOverlay = DebugOverlay()
    
    // MARK: Input
    var joystick = Joystick()
//    var button1 = Button()
//    var button2 = Button()
    
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        joystick = Joystick(position: CGPoint(x: -(self.frame.width / 2) + joystick.sprite.size.width / 2, y: -(self.frame.height / 2) + joystick.sprite.size.height / 2)      )
//        button1 = Button(position: CGPoint(x: -(0.5 * joystick.sprite.size.width + button1.sprite.size.width / 2), y: -(self.frame.height / 2) + (joystick.sprite.size.height / 2) ) )
//        button2 = Button(position: CGPoint(x: (0.5 * joystick.sprite.size.width + button2.sprite.size.width / 2), y: -(self.frame.height / 2) + (joystick.sprite.size.height / 2) ) )
        
        
        
        self.addChild(joystick.sprite)
//        self.addChild(button1.sprite)
//        self.addChild(button2.sprite)
        self.addChild(world.sprite)
        
        world.setTile(gridPoint: GridPoint(x: 3,y: 3), tile: Tile(tileDefinition: world.tileFactory.tileDefinitions["wall"]!, gridPosition: GridPoint(x: 3, y: 3)))
        
        debugOverlay = DebugOverlay(size: self.frame.size)
        self.addChild(debugOverlay.sprite)
        debugOverlay.toggle()
    }
    
    // MARK: input
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        //toggle debugoverlay if three fingers are pressed at the top of the screep
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
        
        var touchLocations: [CGPoint] = []
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode!(self)
            println("x: \(touchLocation.x) y: \(touchLocation.y)")
            touchLocations.append(touchLocation)

        }
        
        joystick.updateVector(touchLocations, ended: false)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var touchLocations: [CGPoint] = []
        for touch: AnyObject in touches {
            
            
            let touchLocation = touch.locationInNode!(self)
            touchLocations.append(touchLocation)

        }
        
        joystick.updateVector(touchLocations, ended: false)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var touchLocations: [CGPoint] = []
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode!(self)
            touchLocations.append(touchLocation)
        }
        joystick.updateVector(touchLocations, ended: true)
    }
   
    
    override func update(currentTime: CFTimeInterval) {
        
        world.update(joystick.vector)
        self.updateDebugLabels()
        
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
