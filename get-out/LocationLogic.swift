//
//  GridPoint.swift
//  get-out
//
//  Created by Cor Pruijs on 28-09-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import SpriteKit

struct GridPoint {
    var x: Int
    var y: Int
}

enum Direction {
    case North
    case East
    case South
    case West
}

func directionfromVector(vector:CGVector) -> Direction? {
    
    let minimumSpeedForDirection: CGFloat = 5
    
    let dxPositive = vector.dx > 0
    let dyPositive = vector.dy > 0
    let dx = vector.dx
    let dy = vector.dy
    
    if !((dx > minimumSpeedForDirection || dx < -minimumSpeedForDirection) || (dy > minimumSpeedForDirection || dy < -minimumSpeedForDirection)) {
        return nil
    }
    
    if dyPositive {
        
        if dy > dx && dy > -dx {
            return .North
        }
    }
    if dxPositive {
        if dx > dy && dx > -dy {
            return .East
        }
    }
    if !dyPositive {
        if dy < dx && dy < -dx {
            return .South
        }
    }
    if !dxPositive {
        if dx < dy && dx < -dy {
            return .West
        }
    }
    
    //        println("ERROR, INVALID VECTOR AT DIRECTION FROM VECTOR")
    return nil
}
