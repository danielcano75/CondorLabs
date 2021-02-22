//
//  GenerationViewModel.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import SwiftUI
import Combine

enum GenerationType: Int {
    case i = 1
    case ii
    case iii
    case iV
}

class GenerationViewModel: ObservableObject {
    @Published var type: GenerationType = .i
    @Published var generations: [Generation] = []
    var cancellation: AnyCancellable?
}

extension GenerationViewModel {
    // MARK: Subscriber implementation
    func get(completion: @escaping () -> ()) {
        cancellation = GenerationClient.request(.generations,
                                                type: type)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink { _ in } receiveValue: {
                self.generations.append($0)
                completion()
            }
    }
}
