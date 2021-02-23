//
//  VoteViewModel.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import SwiftUI

class VoteViewModel: ObservableObject {
    @Published var pokemon: [Pokemon] = []
    var type: GenerationType
    
    init(type: GenerationType,
         pokemon: [Pokemon]) {
        self.type = type
        self.pokemon = pokemon
    }
}
