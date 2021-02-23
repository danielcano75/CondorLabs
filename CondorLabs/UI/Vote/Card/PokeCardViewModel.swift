//
//  PokeCardViewModel.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import SwiftUI
import Combine

enum SwipeStatus: Int {
    case like = 1
    case dislike
    case none
}

class PokeCardViewModel: ObservableObject {
    @Published var pokemon: PokemonDetail = .init()
    var cancellation: AnyCancellable?
    
    var type: GenerationType
    var id: Int
    
    init(type: GenerationType,
         id: Int) {
        self.type = type
        self.id = id
        get()
    }
}

extension PokeCardViewModel {
    // MARK: Subscriber implementation
    func get() {
        cancellation = PokemonClient.request(.pokemon,
                                             id: id)
            .mapError({ (error) -> Error in
                print(error)
                self.pokemon = .init()
                return error
            })
            .sink(receiveCompletion: { (_) in
            }, receiveValue: { pokemon in
                withAnimation(.easeIn) {
                    self.pokemon = pokemon
                }
            })
    }
}
