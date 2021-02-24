//
//  PokemonDetailViewModel.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import SwiftUI
import Combine

class PokemonDetailViewModel: ObservableObject {
    private let database = PokemonDB.shared
    
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
    @Published var status: SwipeStatus = .none
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

extension PokemonDetailViewModel {
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
                self.pokemon.moves = Array(self.pokemon.moves.choose(5))
            }
        })
    }
    
    func getStatus() {
        let pokemon = database.pokemon(by: id)
        if pokemon.status > .zero {
            status = SwipeStatus(rawValue: pokemon.status) ?? .none
        }
    }
    
    func update() {
        if status == .like {
            database.update(by: id,
                            status: SwipeStatus.dislike.rawValue)
            withAnimation {
                status = .dislike
            }
        } else {
            database.update(by: id,
                            status: SwipeStatus.like.rawValue)
            withAnimation {
                status = .like
            }
        }
    }
}

//MARK: MOCK
#if DEBUG
extension PokemonDetailViewModel {
    static var mock = PokemonDetailViewModel(.mock,
                                             type: .i,
                                             id: 1)
}
#endif
