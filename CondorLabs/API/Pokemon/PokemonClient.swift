//
//  PokemonClient.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 23/02/21.
//

import Foundation

import Combine

enum PokemonClient {
    static let api = APIClient()
    static let base = URL(string: Constant.default.Base)!
}

extension PokemonClient {
    static func request(_ path: APIPath,
                        id: Int) -> AnyPublisher<PokemonDetail, Error> {
        guard let components = URLComponents(url: base.appendingPathComponent(path.rawValue + "/\(id)"),
                                             resolvingAgainstBaseURL: true) else {
            fatalError("Couldn't create URLComponents")
        }
        let request = URLRequest(url: components.url!)
        
        return api.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func request(_ path: String) -> AnyPublisher<Move, Error> {
        guard let components = URLComponents(url: URL(string: path)!,
                                             resolvingAgainstBaseURL: true) else {
            fatalError("Couldn't create URLComponents")
        }
        let request = URLRequest(url: components.url!)
        
        return api.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
