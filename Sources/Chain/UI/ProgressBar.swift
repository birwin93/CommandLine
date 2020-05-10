//
//  ProgressBar.swift
//  Chain
//
//  Created by Billy Irwin on 5/9/20.
//

public class ProgressBar {
    
    private var completed: Int = 0
    private let total: Int
    
    private let minSize: Int
    
    private var charactersPerUnit: Int {
        if total > minSize {
            return 1
        } else {
            return minSize / total
        }
    }
    
    public init(total: Int, minSize: Int = 30) {
        self.total = total
        self.minSize = minSize
        printBar()
    }
    
    public func increment(by value: Int = 1) {
        completed += value
        printBar()
    }
    
    private func printBar() {
        var bar: String = "["
        bar += String(repeating: "=", count: completed * charactersPerUnit)
        bar += String(repeating: " ", count: (total - completed) * charactersPerUnit)
        bar += String("] ")
        bar += String(100 * completed / total) + "%"
        
        if completed < total {
            bar += "\r"
        }
        
        print(bar)
    }
}
