//
//  GenerationSegment.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import Foundation

enum GenerationType: Int {
    case i = 1
    case ii
    case iii
    case iv
}

struct GenerationSegment: Hashable, Identifiable {
    var id: Int = GenerationType.i.rawValue
    var generation: GenerationType = .i
    var name: String = "I"
}
