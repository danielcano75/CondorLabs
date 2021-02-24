//
//  MoveViewModel.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import SwiftUI
import Combine

class MoveViewModel: ObservableObject {
    @Published var move: Move = .init()
    
    private var client: PokemonClient
    var cancellation: AnyCancellable?
    var url: String
    var isFirst: Bool
    
    init(_ client: PokemonClient,
         url: String,
         isFirst: Bool) {
        self.client = client
        self.url = url
        self.isFirst = isFirst
        get()
    }
}

extension MoveViewModel {
    // MARK: Subscriber implementation
    func get(completion: (() -> ())? = nil) {
        cancellation = client.moves(url)
            .mapError({ (error) -> Error in
                print(error)
                self.move = .init()
                return error
            })
            .sink(receiveCompletion: { (_) in
            }, receiveValue: { move in
                withAnimation(.easeIn) {
                    self.move = move
                    if self.isFirst {
                        completion?()
                    }
                }
            })
    }
}

//MARK: MOCK
#if DEBUG
extension MoveViewModel {
    static var mock = MoveViewModel(.mock,
                                    url: "https://pokeapi.co/api/v2/move/13/",
                                    isFirst: true)
}
#endif
