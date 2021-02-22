//
//  GenerationClient.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import Foundation
import Combine

enum GenerationClient {
    static let api = APIClient()
    static let base = URL(string: Constant.default.Base)!
}

extension GenerationClient {
    static func request(_ path: APIPath,
                        type: GenerationType) -> AnyPublisher<Generation, Error> {
        guard let components = URLComponents(url: base.appendingPathComponent(path.rawValue + "/\(type.rawValue)"),
                                             resolvingAgainstBaseURL: true) else {
            fatalError("Couldn't create URLComponents")
        }
        let request = URLRequest(url: components.url!)
        
        return api.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
