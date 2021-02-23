//
//  PokemonSegment.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import Foundation

enum PokemosSegementType: Int {
    case info = 1
    case moves
}

struct PokemosSegement: Hashable, Identifiable {
    var id: Int = PokemosSegementType.info.rawValue
    var type: PokemosSegementType = .info
    var name: String = "Info"
}
