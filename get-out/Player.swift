//
//  Player.swift
//  get-out
//
//  Created by Cor Pruijs on 14-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit


class Player: SubclassNode {
    
    // MARK: Textures and animations
    let idleTexture = SKTexture(imageNamed: "player")
    let animationActionsFactory = AnimationActionsFactory()
    let walkingFramesActions: [Direction:SKAction]
    
    // MARK: Speed values
    let slowDownMultiplier: CGFloat = 0.7
    let speedMultiplier: CGFloat = 3
    var slowDownEnabled: Bool = true
    
    // MARK: current values
    var currentGridPosition: CGPoint = CGPoint()
    var currentTile: Tile?
    var currentDirection: Direction? = nil
    var currentAnimation: Direction? = nil
    
    // stats
    var health: Int = 100 
    
    var isAlive: Bool {
        return health > 0
    }
    
    var currentWeapon: Weapon? {
        
        willSet {
            // remove current weapon sprite
            if currentWeapon != nil {
                self.currentWeapon!.removeFromParent()
            }
        }
        
        didSet {
            // add weapon sprite to player sprite
            if currentWeapon != nil {
                self.addChild(currentWeapon!)
            }
        }
    }
    
    // MARK: Initializers
    
    override init() {
        
        walkingFramesActions = animationActionsFactory.getActions()
        
        super.init(texture: nil, color: nil, size: CGSize())
        
        //sprite configuration
        name = "player"
        size = CGSize(width: 64, height: 64)
        texture = SKTexture(imageNamed: "player")
        texture?.filteringMode = .Nearest
    
        //position
        zPosition = 100
        currentGridPosition = CGPoint()
        currentTile = Tile()
        
        //physicis
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2 - 1)
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = ColliderType.Player.rawValue
        physicsBody?.contactTestBitMask = ColliderType.Enemy.rawValue | ColliderType.Bullet.rawValue
    
        //weapon configuration
        currentWeapon = Weapon()
        addChild(currentWeapon!)
        
    }
    
    convenience init(position: CGPoint) {
        self.init()
        self.position = position
    }
    
    
    // Move the player to a Tile
    func moveToTile(tile: Tile) {
        
        let newX = tile.position.x + self.size.width / 2
        let newY = tile.position.y + self.size.height / 2
        let newLocation = CGPoint(x: newX, y: newY)
        let moveAction = SKAction.moveTo(newLocation, duration: 1)
        
        runAction(moveAction)
    }
    
    //Update Sprite to use the corerct animation from walkingFramesActions[:]
    private func updateAnimation() {
    
        func stopAnimation() {
            removeActionForKey("playerMoving")
            texture = idleTexture
        }
        
        let velocity = physicsBody?.velocity
        let direction = directionfromVector(velocity!)
        
        if direction != currentAnimation {
            if direction != nil {
                runAction(self.walkingFramesActions[direction!]!, withKey: "playerMoving")
                currentAnimation = direction
            }
            else {
                currentAnimation = nil
                stopAnimation()
            }
        }
        
    }
    
    func update(#inputMove: CGVector?, inputShoot: CGVector?) {
        
        move(vector: inputMove)
        
        if inputShoot != nil {
            shoot(vector: inputShoot!)
        }
        
        updateAnimation()
        updateCurrentGridPosition()
     
    }
    
    // moves the player by a vector, uses the speedMultiplier property
    func move(#vector: CGVector?) {
        if vector != nil {
            physicsBody?.velocity.dx = vector!.dx * speedMultiplier
            physicsBody?.velocity.dy = vector!.dy * speedMultiplier
        } else {
            if slowDownEnabled {
                physicsBody?.velocity.dx *= slowDownMultiplier
                physicsBody?.velocity.dy *= slowDownMultiplier
            }
        }
    }
    
    func shoot(#vector: CGVector) {
        
        if let weapon = currentWeapon {
            weapon.shoot(direction: vector)
        }
        
    }
    
    private func updateCurrentGridPosition() {
        var position = self.position
        
        // adjust position to represent feet
        position.x += 64
        position.y += 32
    
        var gridPoint = CGPoint(x: Int(position.x / 64) - 1, y: Int(position.y / 64) - 1)
        
        currentGridPosition = gridPoint
    }
    
}