//
//  Move.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import SwiftUI

struct Move: Codable, Identifiable {
    var id: Int = .zero
    var accuracy: Int? = .zero
    var name: String = ""
    var power: Int? = .zero
    var pp: Int = .zero
    var priority: Int = .zero
    var type: MoveType = .init()
    var entries: [Entry] = []
    
    struct MoveType: Codable {
        var name: String = ""
        var url: String = ""
    }
    
    struct Entry: Codable {
        var effect: String = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case accuracy
        case name
        case power
        case pp
        case priority
        case type
        case entries = "effect_entries"
    }
}

extension Move {
    func color() -> Color {
        return Color.type(TypePokemon.type(type.name))
    }
}

#if DEBUG
extension Move {
    static var mock = Move(id: 1,
                           accuracy: 100,
                           name: "pound",
                           power: 40,
                           pp: 35,
                           priority: .zero,
                           type: .mock,
                           entries: [.mock])
    static func mock(id: Int = 1,
                     accuracy: Int? = 100,
                     name: String = "pound",
                     power: Int? = 40,
                     pp: Int = 35,
                     priority: Int = .zero,
                     type: MoveType = .mock(),
                     entries: [Entry] = [.mock()]) -> Move {
        .init(id: id,
              accuracy: accuracy,
              name: name,
              power: power,
              pp: pp,
              priority: priority,
              type: type,
              entries: entries)
    }
}

extension Move.MoveType {
    static var mock = Move.MoveType(name: "normal",
                                    url: "https://pokeapi.co/api/v2/type/1/")
    static func mock(name: String = "normal",
                     url: String = "https://pokeapi.co/api/v2/type/1/") -> Move.MoveType {
        .init(name: name,
              url: url)
    }
}

extension Move.Entry {
    static var mock = Move.Entry(effect: "Inflicts regular damage.")
    static func mock(effect: String = "Inflicts regular damage.") -> Move.Entry {
        .init(effect: effect)
    }
}
#endif
