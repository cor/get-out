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
    var debugLabel = DebugLabel()
    var debugLabels: [DebugLabel] = []
    
    
    override func didMoveToView(view: SKView) {
        
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        joystick = Joystick(position: CGPoint(x: 0, y: -164))
        joystick.sprite.zPosition = 9000
        
        self.addChild(joystick.sprite)
        self.addChild(world.sprite)
        
        world.setTile(gridPoint: GridPoint(x: 3,y: 3), tile: Tile(tileDefinition: world.tileFactory.tileDefinitions["wall"]!, gridPosition: GridPoint(x: 3, y: 3)))
        
        debugLabel = DebugLabel(position: CGPoint(x: -(self.frame.width / 2), y: self.frame.height / 2))
        self.addChild(debugLabel.label)
        
        
        self.generateDebugLabels()
        self.addDebugLabels()
        
        
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
//        debugLabel.update("\(world.player.sprite.position.x)")
        self.updateDebugLabels()
    }
    
    
    func generateDebugLabels() {
        for index in 0...2 {
            let newLabel = DebugLabel(position: CGPoint(x: -(self.frame.size.width / 2), y: ((self.frame.size.height / 2) - (16 * CGFloat(index)))))
            
            // this is kinda hacky... will think of a better solution.
            // this might very well be the worst code i'll ever write, (combining a for loop and a switch), but i'm tired and i want this to work.
            
            switch index {
            case 0:
                newLabel.name = "x"
            case 1:
                newLabel.name = "y"
            case 2:
                newLabel.name = "player alive"
            default:
                println("invalid index at generate debuglabels")
            }
            
            
            debugLabels.append(newLabel)
            
        }
    }
    
    func addDebugLabels() {
        for label in debugLabels {
            self.addChild(label.label)
        }
    }
    
    func updateDebugLabels() {
        for label in debugLabels {
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
