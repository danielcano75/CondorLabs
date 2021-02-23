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
    var type: Type = .init()
    var entries: [Entry] = []
    
    struct `Type`: Codable {
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
