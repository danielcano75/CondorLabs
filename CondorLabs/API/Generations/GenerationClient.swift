//
//  GenerationClient.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import Foundation
import Combine

struct GenerationClient {
    var generation: (_ path: APIPath, _ type: GenerationType) -> AnyPublisher<Generation, Error>
}

// MARK: - LIVE
extension GenerationClient {
    static var live = GenerationClient { path, type in
        guard let components = URLComponents(url: Constant.default.Base.appendingPathComponent(path.rawValue + "/\(type.rawValue)"),
                                             resolvingAgainstBaseURL: true) else {
            fatalError("Couldn't create URLComponents")
        }
        let request = URLRequest(url: components.url!)
        
        return Constant.default.Api.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

#if DEBUG
// MARK: - MOCK
extension GenerationClient {
    static var mock = GenerationClient { _, _ in Effect<Generation, Error>(value: .mock).eraseToAnyPublisher() }
    
    static func mock(generation: @escaping (_ path: APIPath, _ type: GenerationType) -> AnyPublisher<Generation, Error> = { _, _ in fatalError() }) -> GenerationClient {
        .init(generation: generation)
    }
}
#endif
