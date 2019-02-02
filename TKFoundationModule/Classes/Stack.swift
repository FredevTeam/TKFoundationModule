//
//  Stack.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/2/3.
//

import Foundation

protocol StackProtocol  {
    associatedtype Element
    
    var isEmpty: Bool {get}
    
    var size: Int{get}
    
    var peek: Element? {get}
    
    mutating func  push(_ newElement: Element)
    
    mutating func pop() -> Element?
}

public struct Stack<T>: StackProtocol {
    
    typealias Element = T
    
    fileprivate var  stack:[T] = []
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    public var size: Int {
        return stack.count
    }
    
    public var peek: T? {
        return stack.last
    }
    
    /// 入栈
    ///
    /// - Parameter newElement: element
    public mutating func push(_ newElement: T) {
        stack.append(newElement)
    }
    
    /// 出栈
    ///
    /// - Returns: element 
    public mutating func pop() -> T? {
        return stack.popLast()
    }
}
