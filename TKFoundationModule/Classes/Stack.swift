//
//  Stack.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/2/3.
//

import Foundation

public protocol StackProtocol  {
    associatedtype Element
    
    var isEmpty: Bool {get}
    
    var size: Int{get}
    
    var peek: Element? {get}
    
    mutating func  push(_ newElement: Element)
    
    mutating func pop() -> Element?
}


/// 栈结构
/// - Note:
///     先进后出
public struct Stack<T>: StackProtocol {
    
    public typealias Element = T
    
    fileprivate var  stack:[T] = []
    
    /// 是否为空
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    /// 栈 大小
    public var size: Int {
        return stack.count
    }
    
    /// 查看最后元素
    /// - Note:
    ///     只返回最有一个元素，不会出栈
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
