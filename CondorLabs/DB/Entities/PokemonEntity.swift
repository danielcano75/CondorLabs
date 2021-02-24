//
//  PokemonEntity.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 24/02/21.
//

import Foundation
import RealmSwift

class PokemonEntity: Object {
    static let idKey = "id"
    
    @objc dynamic var id: Int = .zero
    @objc dynamic var name: String = ""
    @objc dynamic var status: Int = .zero
    
    override static func primaryKey() -> String? {
        return idKey
    }
}
