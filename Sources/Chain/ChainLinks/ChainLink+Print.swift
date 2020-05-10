//
//  DelayStep.swift
//  Chain
//
//  Created by Billy Irwin on 5/9/20.
//

import Foundation

public struct ChainLink {
        
    public static func print<T>(_ messageProducer: @escaping (T) -> String) -> Link<T, T> {
        return Link<T, T>.sync { input in
            Swift.print(messageProducer(input))
            return input
        }
    }
}
