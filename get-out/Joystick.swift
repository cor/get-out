//
//  Joystick.swift
//  get-out
//
//  Created by Cor Pruijs on 19-10-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class Joystick {
    
    var sprite: SKSpriteNode

    var vector : CGVector? // this is the "Output" of the Joystick
    var startTouch : UITouch? // the touch that is currently on the Joystick
    
    private let disabledAlpha: CGFloat = 0.2
    private let enabledAlpha: CGFloat = 1
    
    // MARK: Initializers
    
    // don't use this one (the initialization part of this class needs some improvement)
    init() {
        sprite = SKSpriteNode(imageNamed: "joystick_move")
        sprite.size = CGSize(width: 128, height: 128)
    }
    
    // do use this one
    convenience init(imageNamed: String, position: CGPoint, name: String) {
        self.init()
        // sprite setup
        sprite = SKSpriteNode(imageNamed: imageNamed)
        sprite.size = CGSize(width: 128, height: 128)
        sprite.name = name
        sprite.position = position
        sprite.texture?.filteringMode = .Nearest
        sprite.alpha = disabledAlpha
        
    }
    
    
    // MARK: Control updates
    func startControl(touch: UITouch, location: CGPoint) {
        
        // keep track of touch
        startTouch = touch
    
        // update vector
        let dx = location.x - sprite.position.x
        let dy = location.y - sprite.position.y
        vector = CGVector(dx: dx, dy: dy)
        
        // update alpha
        sprite.alpha = enabledAlpha
    }
    
    func updateControl(newLocation: CGPoint) {
        
        // update vector
        let dx = newLocation.x - sprite.position.x
        let dy = newLocation.y - sprite.position.y
        vector = CGVector(dx: dx, dy: dy)
        
        // If the finger is moved outside the joystick, use the maximum value
        if vector!.dx > +(self.sprite.size.width / 2) {
            vector!.dx = +(self.sprite.size.width / 2)
        }
        
        if vector!.dx < -(self.sprite.size.width / 2) {
            vector!.dx = -(self.sprite.size.width / 2)
        }
        
        if vector!.dy > +(self.sprite.size.height / 2) {
            vector!.dy = +(self.sprite.size.height / 2)
        }
        
        if vector!.dy < -(self.sprite.size.height / 2) {
            vector!.dy = -(self.sprite.size.height / 2)
        }
    }
    
    func endControl() {
        startTouch = nil
        vector = nil
        
        // update alpha
        sprite.alpha = disabledAlpha
    }
    
}