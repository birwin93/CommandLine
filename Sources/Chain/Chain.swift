//
//  Command.swift
//  bms_cli
//
//  Created by Billy Irwin on 5/9/20.
//

import ArgumentParser
import Combine
import Foundation

public protocol ChainCommand: ParsableCommand {
            
    func run() -> AnyPublisher<Void, Error>
}

extension ChainCommand {
    
    public func run() throws {
        let semaphore = DispatchSemaphore(value: 0)

        var chainError: Error?
        
        let _ = run().sink(
            receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    chainError = error
                }
                semaphore.signal()
            },
            receiveValue: { _ in
                semaphore.signal()
            }
        )
        
        semaphore.wait()

        if let error = chainError {
            throw error
        }
    }
}
