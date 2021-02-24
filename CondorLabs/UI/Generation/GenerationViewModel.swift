//
//  GenerationViewModel.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import SwiftUI
import Combine

class GenerationViewModel: ObservableObject {
    private let database = PokemonDB.shared
    
    private var client: GenerationClient
    
    init(_ client: GenerationClient) {
        self.client = client
    }
    
    @Published var search: String = "" {
        didSet {
            if search.isEmpty {
                pokemon = generation.pokemon.map {
                    Pokemon(id: UUID(),
                            name: $0.name,
                            url: $0.url)
                }
            } else {
                pokemon = generation.pokemon.map {
                    Pokemon(id: UUID(),
                            name: $0.name,
                            url: $0.url)
                }.filter {
                    $0.name.lowercased().contains(search.lowercased()) || "\($0.getId())" == search
                }
            }
        }
    }
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
    @Published var pokemon: [Pokemon] = []
    var cancellation: AnyCancellable?
}

extension GenerationViewModel {
    // MARK: Subscriber implementation
    func get() {
        cancellation = client.generation(.generation, type.generation)
            .mapError { (error) -> Error in
                print(error)
                self.search = ""
                self.generation = .init()
                self.pokemon = []
                return error
            }.sink { _ in } receiveValue: { generation in
                withAnimation(.easeIn) {
                    self.generation = generation
                    self.generation.pokemon.sort {
                        $0.getId() < $1.getId()
                    }
                    self.pokemon = self.generation.pokemon.map {
                        Pokemon(id: UUID(),
                                name: $0.name,
                                url: $0.url)
                    }
                    self.name = generation.Name()
                }
            }
    }
    
    func random() -> [Pokemon] {
        let entities = Set(database.pokemon().map { $0.id })
        var models = Set(generation.pokemon.map { $0.getId() })
        
        models.subtract(entities)
        
        let pokemon = generation.pokemon.filter { pokemon in
            models.contains { id in
                pokemon.getId() == id
            }
        }
        return Array(pokemon.choose(10))
    }
}

//MARK: MOCK
#if DEBUG
extension GenerationViewModel {
    static var mock = GenerationViewModel(.mock)
}
#endif
