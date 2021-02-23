//
//  TypeColor.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import SwiftUI

enum TypePokemon: String {
    case normal = "Normal"
    case fire = "Fire"
    case water = "Water"
    case grass = "Grass"
    case electric = "Electric"
    case ice = "Ice"
    case fighting = "Fighting"
    case poison = "Poison"
    case ground = "Ground"
    case flying = "Flying"
    case psychic = "Psychic"
    case bug = "Bug"
    case rock = "Rock"
    case ghost = "Ghost"
    case dark = "Dark"
    case dragon = "Dragon"
    case steel = "Steel"
    case fairy = "Fairy"
    
    static func types() -> [TypePokemon] {
        return [
            .normal, .fire, .water, .grass, .electric, .ice, .fighting, .poison, .ground, .flying, .psychic, .bug, .rock, .ghost, .dark, .dragon, .steel, .fairy
        ]
    }
    
    static func type(_ name: String) -> TypePokemon {
        let first = types().first {
            $0.rawValue.lowercased() == name
        }
        guard let type = first else {
            return .normal
        }
        return type
    }
}
