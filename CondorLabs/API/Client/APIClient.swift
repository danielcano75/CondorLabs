//
//  APIClient.swift
//  CondorLabs
//
//  Created by Daniel Cano Arbelaez on 22/02/21.
//

import Foundation
import Combine

public struct Effect<Output, Failure: Error>: Publisher {
    public let upstream: AnyPublisher<Output, Failure>
    
    public func receive<S>(subscriber: S) where S: Combine.Subscriber, Failure == S.Failure, Output == S.Input {
      self.upstream.subscribe(subscriber)
    }
    
    public init<P: Publisher>(_ publisher: P) where P.Output == Output, P.Failure == Failure {
      self.upstream = publisher.eraseToAnyPublisher()
    }
    
    public init(value: Output) {
      self.init(Just(value).setFailureType(to: Failure.self))
    }

    public init(error: Failure) {
      self.init(Fail(error: error))
    }
}

struct ErrorMessage: Swift.Error, Equatable {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
}

enum APIPath: String {
    case generation = "/generation"
    case pokemon = "/pokemon"
}

struct APIClient {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


