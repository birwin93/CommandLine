//
//  main.swift
//  ArgumentParser
//
//  Created by Billy Irwin on 5/9/20.
//

import Chain
import Combine
import Foundation

extension ChainLink {
        
    static func fetchValue(_ value: Int) -> Link<Void, Int> {
        return Link<Void, Int>.sync { value }
    }
    
    static func incrementor(by amount: Int = 1) -> Link<Int, Int> {
        return Link<Int, Int>.sync { $0 + amount }
    }
    
    static func progressBar<T>() -> Link<T, Void> {
        return Link<T, Void>.sync { _ in
            let progressBar = ProgressBar(total: 10)
            for _ in 0..<10 {
                progressBar.increment()
                sleep(UInt32(1))
            }
        }
    }
}

struct DemoCommand: ChainCommand {
    
    func run() -> AnyPublisher<Void, Error> {
        return Publishers
            .link(ChainLink.fetchValue(5))
            .link(ChainLink.incrementor())
            .link(ChainLink.print { "\($0)" })
            .link(ChainLink.incrementor())
            .link(ChainLink.print { "\($0)" })
            .link(ChainLink.progressBar())
    }
}

DemoCommand.main()
