//
//  PokemonDetailViewModel.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import SwiftUI
import Combine

class PokemonDetailViewModel: ObservableObject {
    @Published var segment: PokemosSegement = .init() {
        didSet {
            if segment.type == .moves {
                get()
            }
        }
    }
    @Published var segments: [PokemosSegement] = [PokemosSegement(id: PokemosSegementType.info.rawValue,
                                                                  type: .info,
                                                                  name: "Info"),
                                                  PokemosSegement(id: PokemosSegementType.moves.rawValue,
                                                                  type: .moves,
                                                                  name: "Moves")]
    @Published var pokemon: PokemonDetail = .init()
    var cancellation: AnyCancellable?
    
    var type: GenerationType
    var id: Int
    
    init(type: GenerationType,
         id: Int) {
        self.type = type
        self.id = id
    }
}

extension PokemonDetailViewModel {
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
