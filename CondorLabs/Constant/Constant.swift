//
//  Constant.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import Foundation

// MARK: Base Server Url Development
fileprivate let defBase       = "https://pokeapi.co/api/v2"
fileprivate let defArtwork    = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/emerald/"

// MARK: End-points
fileprivate let defGeneration = "/generation"

struct Constant {
    let Base        : String
    let Artwork     : String
    let Generation  : String
    
    static let `default` = Constant(Base: defBase,
                                    Artwork: defArtwork,
                                    Generation: defGeneration)
}
