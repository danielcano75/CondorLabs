//
//  PokemonDetail.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import SwiftUI

struct PokemonDetail: Codable {
    var id: Int = .zero
    var abilities: [Ability] = []
    var name: String = ""
    var sprites: Sprites = .init()
    var types: [PokemonType] = []
    var pokedexId: Int = .zero
    var weight: Int = .zero
    var height: Int = .zero
    var moves: [PokemonMove] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case abilities
        case name
        case sprites
        case types
        case pokedexId = "order"
        case weight
        case height
        case moves
    }
}

struct Ability: Codable {
    var ability: Detail = .init()
    
    struct Detail: Codable {
        var name: String = ""
        var url: String = ""
    }
}

struct Sprites: Codable {
    var other: Other = .init()
}

struct Other: Codable {
    var artwork: Artwork = .init()
    
    enum CodingKeys: String, CodingKey {
        case artwork = "official-artwork"
    }
}

struct Artwork: Codable {
    var artwork: String = ""
    
    enum CodingKeys: String, CodingKey {
        case artwork = "front_default"
    }
}

struct PokemonType: Codable, Identifiable {
    var id: Int = .zero
    var type: Type = .init()

    struct `Type`: Codable {
        var name: String = ""
        var url: String = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "slot"
        case type
    }
}

extension PokemonType {
    func color() -> Color {
        return Color.type(TypePokemon.type(type.name))
    }
}

struct PokemonMove: Codable {
    var move: Move = .init()
    var details: [Detail] = []
    
    struct Move: Codable {
        var name: String = ""
        var url: String = ""
    }
    
    struct Detail: Codable {
        var level: Int = .zero
        var method: Method = .init()
        var version: Version = .init()
        
        struct Method: Codable {
            var name: String = ""
            var url: String = ""
        }
         
        struct Version: Codable {
            var name: String = ""
            var url: String = ""
        }
        
        enum CodingKeys: String, CodingKey {
            case level = "level_learned_at"
            case method = "move_learn_method"
            case version = "version_group"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case move
        case details = "version_group_details"
    }
}
