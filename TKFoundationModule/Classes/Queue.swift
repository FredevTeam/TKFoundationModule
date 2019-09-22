//
//  Queue.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/2/3.
//

import Foundation


/// 队列协议
public protocol QueueProtocol  {
    associatedtype Element
    
    var isEmpty: Bool {get}
    
    var size: Int{get}
    
    var peek: Element? {get}
    
    /// 入队
    mutating func enter(_ newElement: Element)
    /// 出队
    mutating func leave() -> Element?

    /// 清空队列
    mutating func removeAll()
}


/// 队列
/// - Note:
///    先进先出
public struct Queue<T>: QueueProtocol {
    public typealias Element  = T
    
    fileprivate var queue:[T] = []


    /// 是否为空
    public var isEmpty: Bool {
        return queue.isEmpty
    }
    
    /// 队列大小
    public var size: Int {
        return queue.count
    }

    /// 获取队列第一个元素
    /// - Note:
    ///     只返回第一个元素，不会出队列
    public var peek: T? {
        return queue.first
    }
    
    /// 入队列
    ///
    /// - Parameter newElement: 元素
    public mutating func enter(_ newElement: T) {
        queue.append(newElement)
    }
    
    /// 出队列
    ///
    /// - Returns: 第一个元素
    public mutating func leave() -> T? {
        if isEmpty {
            return nil
        }
        return queue.removeFirst()
    }

    /// 清空队列
    public mutating func removeAll() {
        self.queue.removeAll()
    }

}
