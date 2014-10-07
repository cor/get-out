//
//  DebugLabel.swift
//  get-out
//
//  Created by Cor Pruijs on 30-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class DebugLabel {
    let label: SKLabelNode
    var name: String
    var value: String
    
    // MARK: Initializers
    init() {
        label = SKLabelNode()
        label.fontName = "Helvetica"
        label.fontSize = 16;
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        
        name = "test"
        value = "3"
    }
    
    convenience init(position: CGPoint) {
        self.init()
        label.position = position
    }
    
    // MARK: Update function
    func update(newValue: String) {
        value = newValue
        label.text = "\(name) : \(value)"
    }
}