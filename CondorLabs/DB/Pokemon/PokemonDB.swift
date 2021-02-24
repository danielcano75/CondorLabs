//
//  PokemonDB.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 24/02/21.
//

import RealmSwift

class PokemonDB {
    static let shared = PokemonDB()
    
    private let byId = "SELF.id == %d"
    
    private lazy var realm: Realm = {
        return try! Realm()
    }()
    
    func pokemon() -> [PokemonEntity] {
        let pokemon = realm.objects(PokemonEntity.self)
        return Array(pokemon)
    }
    
    func pokemon(by id: Int) -> PokemonEntity {
        guard let pokemon = realm.objects(PokemonEntity.self).filter(byId, id).first else {
            return .init()
        }
        return pokemon
    }
    
    func save(pokemon: PokemonEntity) {
        try! realm.safeWrite {
            realm.add(pokemon)
        }
    }
    
    func update(by id: Int,
                status: Int) {
        guard let pokemon = realm.objects(PokemonEntity.self).filter(byId, id).first else {
            return
        }
        try! realm.safeWrite {
            pokemon.status = status
        }
    }
}
