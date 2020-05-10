//
//  Link.swift
//  Chain
//
//  Created by Billy Irwin on 5/10/20.
//

import Combine
import Foundation

public final class Link<I, O>: Chainable {

    private let block: (I) -> AnyPublisher<O, Error>

    public required init(block: @escaping (I) -> AnyPublisher<O, Error>) {
        self.block = block
    }
    
    public static func async<I, O>(block:  @escaping (I) -> AnyPublisher<O, Error>) -> Link<I, O> {
        return Link<I, O>(block: block)
    }
    
    public static func sync<I, O>(block: @escaping (I) throws -> O) -> Link<I, O> {
        let futureBlock: (I) -> AnyPublisher<O, Error> = { input in
            return Future { promise in
                do {
                    let result = try block(input)
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }.eraseToAnyPublisher()
        }
        
        return Link<I, O>(block: futureBlock)
    }

    public func execute(_ input: I) -> AnyPublisher<O, Error> {
        return block(input)
    }
}
