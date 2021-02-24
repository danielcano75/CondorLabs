//
//  MoveViewModel.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import SwiftUI
import Combine

class MoveViewModel: ObservableObject {
    private var client = PokemonClient.live
    
    @Published var move: Move = .init()
    var cancellation: AnyCancellable?
    var url: String
    var isFirst: Bool
    
    init(url: String,
         isFirst: Bool) {
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
