//
//  Link.swift
//  BMSCLI
//
//  Created by Billy Irwin on 5/9/20.
//

import Combine
import Foundation

public protocol Chainable {
    
    associatedtype Input
    associatedtype Output
    
    func execute(_ input: Input) -> AnyPublisher<Output, Error>
}

extension Publisher {

    public func link<C: Chainable>(_ chainable: C) -> AnyPublisher<C.Output, Error> where Output == C.Input, Failure == Error {
        return self
            .flatMap { input -> AnyPublisher<C.Output, Error> in
                return chainable.execute(input)
            }
            .eraseToAnyPublisher()
    }
}

extension Publishers {

    public static func link<C: Chainable>(_ chainable: C) -> AnyPublisher<C.Output, Error> where C.Input == Void {
        return Future<Void, Error>{ $0(.success(Void())) }.link(chainable)
    }
}
