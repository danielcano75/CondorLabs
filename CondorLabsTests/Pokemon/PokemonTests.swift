//
//  PokemonTests.swift
//  CondorLabsTests
//
//  Created by Daniel Cano Arbelaez on 24/02/21.
//

import XCTest

class PokemonTests: XCTestCase {
    func testLoadPokemon() throws {
        let viewModel = PokemonDetailViewModel(.mock(pokemon: { _, _ in
            Effect(value: .mock).eraseToAnyPublisher()
        }), type: .i, id: 1)
        viewModel.pokemon = .mock
        
        XCTAssert(viewModel.pokemon.id == 1)
    }
    
    func testFailedPokemon() throws {
        let viewModel = PokemonDetailViewModel(.mock(pokemon: { _, _ in
            Effect(error: ErrorMessage("Failure"))
                .eraseToAnyPublisher()
        }), type: .i, id: 1)
        
        XCTAssert(viewModel.pokemon.id == .zero)
    }
}
