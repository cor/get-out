//
//  TileDefinition.swift
//  get-out
//
//  Created by Cor Pruijs on 07-10-14.
//  Copyright (c) 2014 Cor Pruijs. All rights reserved.
//

import Foundation

struct TileDefinition {
    let textureName: String
    let collides: Bool
}

class TileFactory {
    var tileDefinitions: [String : TileDefinition] = [:]
    
    init() {
        tileDefinitions["floor"] = TileDefinition(textureName: "tile_floor", collides: false)
        tileDefinitions["wall"] = TileDefinition(textureName: "tile_wall", collides: true)
    }
}