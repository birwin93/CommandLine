//
//  FileSteps.swift
//  Chain
//
//  Created by Billy Irwin on 5/9/20.
//

import Foundation
import Combine

extension ChainLink {
    
    public static func readFile<T>(_ urlString: String) -> Link<T, String> {
        return Link<T, String>.sync { _ in
            guard FileManager.default.fileExists(atPath: urlString) else {
                throw FileError.fileNotFound
            }
            
            return try String(contentsOf: URL(fileURLWithPath: urlString))
        }
    }
}

public enum FileError: Error {
    case fileNotFound
    case invalidData
}
