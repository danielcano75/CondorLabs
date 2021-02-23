//
//  GenerationViewModel.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import SwiftUI
import Combine

class GenerationViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var type: GenerationSegment = .init() {
        didSet {
            if oldValue != type {
                get()
            }
        }
    }
    @Published var types: [GenerationSegment] = [GenerationSegment(id: GenerationType.i.rawValue,
                                                                   generation: .i,
                                                                   name: "I"),
                                                 GenerationSegment(id: GenerationType.ii.rawValue,
                                                                   generation: .ii,
                                                                   name: "II"),
                                                 GenerationSegment(id: GenerationType.iii.rawValue,
                                                                   generation: .iii,
                                                                   name: "III"),
                                                 GenerationSegment(id: GenerationType.iv.rawValue,
                                                                   generation: .iv,
                                                                   name: "IV")]
    @Published var generation: Generation = .init()
    var cancellation: AnyCancellable?
}

extension GenerationViewModel {
    // MARK: Subscriber implementation
    func get() {
        cancellation = GenerationClient.request(.generations,
                                                type: type.generation)
            .mapError({ (error) -> Error in
                print(error)
                self.generation = .init()
                return error
            })
            .sink { _ in } receiveValue: { generation in
                withAnimation(.easeIn) {
                    self.generation = generation
                    self.name = generation.Name()
                }
            }
    }
}
