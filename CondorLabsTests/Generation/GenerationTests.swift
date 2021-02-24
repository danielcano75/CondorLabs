//
//  GenerationTests.swift
//  CondorLabsTests
//
//  Created by Daniel Cano Arbelaez on 24/02/21.
//

import XCTest

class GenerationTests: XCTestCase {
    
    func testLoadGeneration() throws {
        let viewModel = GenerationViewModel(.mock(generation: { (_, _) in
            Effect(value: .mock)
                .eraseToAnyPublisher()
        }))
        viewModel.generation = .mock
        
        XCTAssert(viewModel.generation.id == 1)
    }
    
    func testFailedGeneration() throws {
        let viewModel = GenerationViewModel(.mock(generation: { (_, _) in
            Effect(error: ErrorMessage("Failure"))
                .eraseToAnyPublisher()
        }))
        
        XCTAssert(viewModel.generation.id == .zero)
    }
}
