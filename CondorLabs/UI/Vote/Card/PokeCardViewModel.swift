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
    
    private var client: PokemonClient
    var type: GenerationType
    var id: Int
    
    init(_ client: PokemonClient,
         type: GenerationType,
         id: Int) {
        self.client = client
        self.type = type
        self.id = id
        get()
    }
}

extension PokeCardViewModel {
    // MARK: Subscriber implementation
    func get() {
        cancellation = client.pokemon(APIPath.pokemon, id)
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
