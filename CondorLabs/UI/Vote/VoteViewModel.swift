//
//  VoteViewModel.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import SwiftUI

class VoteViewModel: ObservableObject {
    private let database = PokemonDB.shared
    
    @Published var pokemon: [Pokemon] = []
    var type: GenerationType
    
    init(type: GenerationType,
         pokemon: [Pokemon]) {
        self.type = type
        self.pokemon = pokemon
    }
}

extension VoteViewModel {
    func save(pokemon: PokemonDetail,
              status: SwipeStatus) {
        let entity = pokemon.toEntity(by: status)
        database.save(pokemon: entity)
        self.pokemon.removeAll {
            $0.getId() == pokemon.id
        }
    }
}
