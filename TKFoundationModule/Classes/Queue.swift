//
//  Queue.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/2/3.
//

import Foundation

protocol QueueProtocol  {
    associatedtype Element
    
    var isEmpty: Bool {get}
    
    var size: Int{get}
    
    var peek: Element? {get}
    
    /// 入队
    mutating func enter(_ newElement: Element)
    /// 出队
    mutating func leave() -> Element?
}


public struct Queue<T>: QueueProtocol {
    typealias Element  = T
    
    fileprivate var queue:[T] = []
    
    public var isEmpty: Bool {
        return queue.isEmpty
    }
    
    public var size: Int {
        return queue.count
    }
    public var peek: T? {
        return queue.first
    }
    
    public mutating func enter(_ newElement: T) {
        queue.append(newElement)
    }
    
    public mutating func leave() -> T? {
        if isEmpty {
            return nil
        }
        return queue.removeFirst()
    }
}
