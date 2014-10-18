//
//  Joystick.swift
//  get-out
//
//  Created by Cor Pruijs on 14-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class Joystick {
    
    // MARK: Public properties
    var vector: CGVector? = nil
    let maxDx: CGFloat
    let maxDy: CGFloat
    
    // MARK: Private properties
    let sprite: SKSpriteNode
    private let vectorMultiplier: CGFloat = 1
    private let centerRadius: CGFloat = 10
    private let disabledAlpha: CGFloat = 0.5
    private let enabledAlpha: CGFloat = 0.7
    
    
    // MARK: Initializers
    init() {
        sprite = SKSpriteNode(imageNamed: "joystick")
        sprite.size = CGSize(width: 128, height: 128)
        sprite.position = CGPoint()
        sprite.zPosition = 9000
        sprite.texture?.filteringMode = .Nearest
        sprite.alpha = 0.5
        
        maxDx = sprite.size.width / 2
        maxDy = sprite.size.height / 2
    }
    
    convenience init(position: CGPoint) {
        self.init()
        sprite.position = position
    }
    
    
    // MARK: Update function
    func updateVector(touchLocations: [CGPoint], ended: Bool) {
        
        if ended {
            var locationInJoystick: CGPoint? = nil
            
            for location in touchLocations {
                
                let dx = (location.x - sprite.position.x)
                let dy = (location.y - sprite.position.y)
                
                if !(dx > +maxDx || dx < -maxDx || dy > +maxDy || dy < -maxDy) {
                    locationInJoystick = location
                }
                
            }
            
            if  locationInJoystick != nil  {
                vector = nil
            }
        } else {
            if touchLocations.count != 0 {
                
                
                // look at all touchlocations to see if there is a location that is on the joystick
                var locationInJoystick: CGPoint? = nil
                for location in touchLocations {
                    
                    let dx = (location.x - sprite.position.x)
                    let dy = (location.y - sprite.position.y)
                    
                    if !(dx > +maxDx || dx < -maxDx || dy > +maxDy || dy < -maxDy) {
                        locationInJoystick = location
                    }
                    
                }
                
                
                // if there is a touchlocation on the joystick, update the vector
                if locationInJoystick != nil {
                    let dx = (locationInJoystick!.x - sprite.position.x)
                    let dy = (locationInJoystick!.y - sprite.position.y)
                    
                    vector = CGVector(
                        dx: (dx > +centerRadius || dx < -centerRadius ? dx * vectorMultiplier : 0),
                        dy: (dy > +centerRadius || dy < -centerRadius ? dy * vectorMultiplier : 0)
                    )
                }
                
            } else {
                // if there isn't any touch on the screen, set the vector to nil
                vector = nil
            }
        }
        
        if vector != nil {
            sprite.alpha = enabledAlpha
        } else {
            sprite.alpha = disabledAlpha
        }
    }
}