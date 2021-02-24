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

extension PokemonDetail {
    func toEntity(by status: SwipeStatus) -> PokemonEntity {
        let pokemon = PokemonEntity()
        pokemon.id = id
        pokemon.name = name
        pokemon.status = status.rawValue
        return pokemon
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
    var type: TypeDesc = .init()
    
    struct TypeDesc: Codable {
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

#if DEBUG
extension PokemonDetail {
    static var mock = PokemonDetail(id: 1,
                                    abilities: [.mock],
                                    name: "bulbasaur",
                                    sprites: .mock,
                                    types: [.mock],
                                    pokedexId: 1,
                                    weight: 69,
                                    height: 7,
                                    moves: [.mock])
    static func mock(id: Int = 1,
                     abilities: [Ability] = [],
                     name: String = "bulbasaur",
                     sprites: Sprites = .mock(),
                     types: [PokemonType] = [.mock()],
                     pokedexId: Int = 1,
                     weight: Int = 69,
                     height: Int = 7,
                     moves: [PokemonMove] = [.mock()]) -> PokemonDetail {
        .init(id: id,
              abilities: abilities,
              name: name,
              sprites: sprites,
              types: types,
              pokedexId: pokedexId,
              weight: weight,
              height: height,
              moves: moves)
    }
}

extension Ability {
    static var mock = Ability(ability: .mock)
    static func mock(ability: Ability.Detail) -> Ability {
        .init(ability: ability)
    }
}

extension Ability.Detail {
    static var mock = Ability.Detail(name: "overgrow",
                                     url: "https://pokeapi.co/api/v2/ability/65/")
    static func mock(name: String = "overgrow",
                     url: String = "https://pokeapi.co/api/v2/ability/65/") -> Ability.Detail {
        .init(name: name,
              url: url)
    }
}

extension Sprites {
    static var mock = Sprites(other: .mock)
    static func mock(other: Other = .mock()) -> Sprites {
        .init(other: other)
    }
}

extension Other {
    static var mock = Other(artwork: .mock)
    static func mock(artwork: Artwork = .mock()) -> Other {
        .init(artwork: artwork)
    }
}

extension Artwork {
    static var mock = Artwork(artwork: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")
    static func mock(artwork: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png") -> Artwork {
        .init(artwork: artwork)
    }
}

extension PokemonType {
    static var mock = PokemonType(id: 1,
                                  type: .mock)
    static func mock(id: Int = 1,
                     type: PokemonType.TypeDesc = .mock()) -> PokemonType {
        .init(id: id,
              type: type)
    }
}

extension PokemonType.TypeDesc {
    static var mock = PokemonType.TypeDesc(name: "grass",
                                           url: "https://pokeapi.co/api/v2/type/12/")
    static func mock(name: String = "grass",
                     url: String = "https://pokeapi.co/api/v2/type/12/") -> PokemonType.TypeDesc {
        .init(name: name,
              url: url)
    }
}

extension PokemonMove {
    static var mock = PokemonMove(move: .mock,
                                  details: [.mock])
    static func mock(move: PokemonMove.Move = .mock(),
                     details: [PokemonMove.Detail] = [.mock()]) -> PokemonMove {
        .init(move: move,
              details: details)
    }
}

extension PokemonMove.Move {
    static var mock = PokemonMove.Move(name: "razor-wind",
                                       url: "https://pokeapi.co/api/v2/move/13/")
    static func mock(name: String = "razor-wind",
                     url: String = "https://pokeapi.co/api/v2/move/13/") -> PokemonMove.Move {
        .init(name: name,
              url: url)
    }
}

extension PokemonMove.Detail {
    static var mock = PokemonMove.Detail(level: .zero,
                                         method: .mock,
                                         version: .mock)
    static func mock(level: Int = .zero,
                     method: PokemonMove.Detail.Method = .mock(),
                     version: PokemonMove.Detail.Version = .mock()) -> PokemonMove.Detail {
        .init(level: level,
              method: method,
              version: version)
    }
}

extension PokemonMove.Detail.Method {
    static var mock = PokemonMove.Detail.Method(name: "egg",
                                                url: "https://pokeapi.co/api/v2/move-learn-method/2/")
    static func mock(name: String = "egg",
                     url: String = "https://pokeapi.co/api/v2/move-learn-method/2/") -> PokemonMove.Detail.Method {
        .init(name: name,
              url: url)
    }
}

extension PokemonMove.Detail.Version {
    static var mock = PokemonMove.Detail.Version(name: "gold-silve",
                                                 url: "https://pokeapi.co/api/v2/version-group/3/")
    static func mock(name: String = "gold-silve",
                     url: String = "https://pokeapi.co/api/v2/version-group/3/") -> PokemonMove.Detail.Version {
        .init(name: name,
              url: url)
    }
}
#endif

