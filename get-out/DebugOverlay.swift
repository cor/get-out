//
//  DebugOverlay.swift
//  get-out
//
//  Created by Cor Pruijs on 07-10-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

class DebugOverlay {
    let sprite = SKSpriteNode()
    let size : CGSize
    var debugLabels : [DebugLabel] = []
    
    var hidden = true
    
    // don't use this initializer
    init() {
        self.size = CGSize(width: 0, height: 0)
    }
    
    // use this initializer
    init(size: CGSize) {
        self.size = size
        generateDebugLabels()
        addDebugLabels()
    }
    
    func generateDebugLabels() {
        for index in 0...2 {
            let newLabel = DebugLabel(position: CGPoint(x: -(self.size.width / 2), y: ((self.size.height / 2) - (16 * CGFloat(index)))))
            
            
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
            sprite.addChild(label.label)
        }
    }
    
    // show / hide the overlay
    func toggle() {
        hidden = !hidden
        sprite.hidden = hidden
    }
}