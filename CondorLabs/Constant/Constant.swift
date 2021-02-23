//
//  Constant.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import Foundation

// MARK: Base Server Url Development
fileprivate let defBase       = "https://pokeapi.co/api/v2"

// MARK: End-points
fileprivate let defGeneration = "/generation"

struct Constant {
    let Base        : String
    let Generation  : String
    
    static let `default` = Constant(Base: defBase,
                                    Generation: defGeneration)
}
