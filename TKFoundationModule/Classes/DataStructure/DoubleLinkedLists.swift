//
//  DoubleLinkedLists.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/8/12.
//

import Foundation



/**
 双向链表节点

 - Date:
 - Author: 抓猫的鱼
 */

public class DoubleLinkedListNode<V> {
    fileprivate(set) public var value: V
    fileprivate(set) public var next: DoubleLinkedListNode<V>?
    fileprivate(set) public var previous: DoubleLinkedListNode<V>?

    public init(_ value: V) {
        self.value = value
    }

    /// 创建双向链表节点
    ///
    /// - Parameters:
    ///   - value: 数据 可以是任意类型数据 basic(string, int) struct class 等
    ///   - next: 下个节点
    ///   - previous: 上个节点
    public init(_ value: V, next: DoubleLinkedListNode<V>? = nil , previous: DoubleLinkedListNode<V>? = nil) {
        self.value = value
        self.next = next
        self.previous = previous
    }
}



/**
 泛型双向链表

 - Date:
 - Author: 抓猫的鱼
 */

public final class DoubleLinkedList<V> {
    private var size = 0
    private var firstNode: DoubleLinkedListNode<V>?
    private var lastNode: DoubleLinkedListNode<V>?

    public init() {
    }
}


// MARK: - Append Extension
extension DoubleLinkedList {

    /// 追加节点
    ///
    /// - Parameter newElement: 新的 元素 数据模型
    /// - Note: 内部会根据数据来创建对应的节点
    public func append(_ newElement: V) {
        let node = DoubleLinkedListNode.init(newElement, next: nil, previous: lastNode)
        if lastNode == nil {
            firstNode = node
        }
        lastNode?.next = node
        lastNode = node
        size += 1
    }

    /// 追加多个
    ///
    /// - Parameter newElements: 数据元素数组
    /// - Note: 内部会根据数组创建多个新的节点追加
    /// - SeeAlso: `append(_ newElement: V)`
    /// - Remark: 多次调用` append(_ newElement: V)`创建节点
    public func append<S>(contentsOf newElements: S) where S : Sequence, V == S.Element {
        for item in newElements {
            append(item)
        }
    }

    /// 插入
    /// 在链表中任意位置插入一个数据位为 `newElement`的节点
    ///
    /// - Parameters:
    ///   - newElement: 数据
    ///   - i: 位置
    /// - Precondition: `i > 0 && i <= size`
    public func insert(_ newElement: V, at i: Int){
        let newNode = DoubleLinkedListNode.init(newElement, next: nil, previous: nil)
        if i == 0 && size == 0{
            firstNode = newNode
            lastNode = newNode
        }else {
            let insertNode = node(at: i)
            newNode.next = insertNode
            insertNode.previous = newNode
            newNode.previous = insertNode.previous
            insertNode.previous?.next = newNode
            if i == 0 {
                firstNode = newNode
            }
        }
        size += 1
    }

    /// 插入多个节点
    /// 在 i 位置依次插入数据为 newElements 中元素的节点
    ///
    /// - Parameters:
    ///   - newElements: 新插入节点数据位数组
    ///   - i: 插入位置
    /// - Precondition: `i > 0 && i <= size`
    public func insert<S>(contentsOf newElements: S, at i: Int) where S : Collection, V == S.Element {
        if i == 0 && size == 0 {
            append(contentsOf: newElements)
        }else {
            let insertNode = node(at: i)
            var firstNode:DoubleLinkedListNode<V>?
            var lastNode:DoubleLinkedListNode<V>?
            for (index,item) in newElements.enumerated() {
                let newNode = DoubleLinkedListNode.init(item, next: nil, previous: nil)
                if index == 0 {
                    firstNode = newNode
                    lastNode = newNode
                }else {
                    newNode.previous = lastNode
                    lastNode?.next = newNode
                    lastNode = newNode
                }
                size += 1
            }
            firstNode?.previous = insertNode.previous
            lastNode?.next = insertNode
            insertNode.previous?.next = firstNode
            insertNode.previous = lastNode
            if i == 0 {
                self.firstNode = firstNode
            }
        }
    }
}

// MARK: - 实现 Collection 协议
extension DoubleLinkedList : Collection {
    /// 开始位置 索引
    public var startIndex: Int {  return 0 }
    /// 结束位置 索引
    public var endIndex: Int { return size }

    /// i 下一个位置索引
    ///
    ///
    /// - Parameter i: 当前位置
    /// - Returns: 下个位置索引
    /// - Note: `i > 0`
    public func index(after i: Int) -> Int {
        return i + 1
    }

    /// 返回迭代器
    ///
    /// - Returns: 当前自己迭代器
    /// - Note:
    ///     `Iterator(self)`
    /// - SeeAlso: `Iterator` class
    public func makeIterator() -> Iterator {
        return Iterator(self)
    }
    /// 通过下标存取元素

    /// 通过下标获取/设置节点数据
    ///
    /// - Parameter position: 下标
    /// - Returns: 节点数据
    public subscript(position: Int) -> V {
        get {
            return node(at: position).value
        }
        set {
            node(at: position).value = newValue
        }
    }
}
// MARK: - 迭代器
extension DoubleLinkedList {

    /// Iterator
    /// - Note:
    ///     实现 IteratorProtocol 协议
    public struct Iterator: IteratorProtocol {
        let list: DoubleLinkedList
        var index: Int
        private var nextNode:DoubleLinkedListNode<V>?
        
        init(_ list: DoubleLinkedList) {
            self.list = list
            self.index = 0
            self.nextNode = list.firstNode
        }
        /// 获取下一个元素，在for in里若返回nil，则停止循环

        /// next
        ///
        /// - Returns: 下一个节点数据
        /// - Note:
        ///     当下个节点为 nil 时停止
        mutating public func next() -> V? {
            let item = nextNode?.value
            nextNode = nextNode?.next
            return item
        }
    }
}

extension DoubleLinkedList {
    private func node(at index: Int) -> DoubleLinkedListNode<V> {
        if index < 0 || index > size {
            fatalError("index out of rang")
        }
        //如果节点在前一半顺序查找，否则逆序查找
        if index < (size >> 1) {
            var node = firstNode
            for _ in 0..<index {
                node = node?.next
            }
            return node!
        }else {
            var node = lastNode
            for _ in stride(from: size - 1, to: index, by: -1) {
                node = node?.previous
            }
            return node!
        }
    }
}



extension DoubleLinkedList {
    /// 删除指定位置的元素
    @discardableResult

    /// 删除节点
    ///
    /// - Parameter position: 位置索引
    /// - Returns: 节点数据
    /// - Note:
    ///     默认返回对应删除节点存储的数据，可以不使用
    public func remove(at position: Int) -> V {
        let removeNode = node(at: position)
        removeNode.previous?.next = removeNode.next
        removeNode.next?.previous = removeNode.previous
        size -= 1
        return removeNode.value
    }

    /// 删除第一个元素
    @discardableResult

    /// 删除第一个节点
    ///
    /// - Returns: 节点数据
    /// - Note:
    ///  链表为空时，返回nil
    public func removefirstNode() -> V? {
        return firstNode == nil ? nil : remove(at: 0)
    }
    /// 删除最后一个元素
    @discardableResult

    /// 删除最后一个节点
    ///
    /// - Returns: 数据 可选类型
    /// - Note:
    ///     链表为空，返回 nil
    public func removelastNode() -> V? {
        return lastNode == nil ? nil : remove(at: size - 1)
    }
    /// 删除所有元素
    /// - Note:
    ///     清空所有链表
    public func removeAll() {
        var next = firstNode
        while next != nil {
            let tmp = next
            next?.next = nil
            next?.previous = nil
            next = tmp
        }
        firstNode = nil
        lastNode = nil
        size = 0
    }

}

extension DoubleLinkedList {
    /// 顺序查找

   /// 正序查找
   ///
   /// - Parameter predicate: 查找条件block
   /// - Returns: 首个符合条件索引 可选类型
   /// - Throws: throws value description
   public func firstIndex(where predicate: (V) throws -> Bool) rethrows -> Int? {
        for (index,item) in self.enumerated() {
            if try predicate(item) {
                return index
            }
        }
        return nil
    }

    /// 倒序查找

    /// 倒序查找
    ///
    /// - Parameter predicate: 查找条件 block
    /// - Returns: 首个符合条件索引，
    /// - Throws: throws value description
    public func lastIndex(where predicate: (V) throws -> Bool) rethrows -> Int? {
        var prev = lastNode
        var currentIndex = size - 1
        while prev != nil {
            if try predicate(prev!.value) {
                return currentIndex
            }
            currentIndex -= 1
            prev = prev?.previous
        }
        return nil
    }

    /// 是否包含

    /// 包含
    ///
    /// - Parameter predicate: 条件block
    /// - Returns: true/ false
    /// - Throws: throws value description
    public func contains(where predicate: (V) throws -> Bool) rethrows -> Bool {
        for item in self {
            if try predicate(item) {
                return true
            }
        }
        return false
    }
}


extension DoubleLinkedList where V : Equatable {


    /// 正序查找
    ///
    /// - Parameter element: 值域
    /// - Returns: 索引
    public func firstIndex(of element: V) -> Int? {
        return firstIndex { (item) -> Bool in
            return item == element
        }
    }

    /// 值域相同的最有一个节点(倒序查找)
    ///
    /// - Parameter element: 值域
    /// - Returns: 索引
    public func lastIndex(of element: V) -> Int? {
        return lastIndex(where: { (item) -> Bool in
            return item == element
        })
    }


    /// 包含
    ///
    /// - Parameter element: 值域
    /// - Returns: true/false
    public func contains(_ element: V) -> Bool {
        return contains(where: { (item) -> Bool in
            return item == element
        })
    }


    /// 通过 值域  获取节点
    ///
    /// - Parameter value: 值
    /// - Returns: 节点， 可选类型值
    public func find(by value: V) -> DoubleLinkedListNode<V>? {
        guard let index = firstIndex(of: value) else { return nil }
        return node(at: index)
    }


   /// 删除节点，通过值域数组
   ///
   /// - Parameter at: 值域数组
   public func removes(at: [V])  {
        at.forEach { (v) in
            guard let index = firstIndex(of: v) else { return }
            remove(at: index)
        }
    }
}
// MARK: - 把LinkedList转成Array
extension DoubleLinkedList {

    /// LINK ----> ARRAY
    ///
    /// - Returns: 数据数组
    /// - Remark:
    ///     将所有节点数据转换为数组返回
   public func toArray() -> [V] {
        return self.map({ (item) -> V in
            return item
        })
    }
}


// MARK: - CustomDebugStringConvertible协议，通过实现该协议，实现自定义打印
extension DoubleLinkedList : CustomDebugStringConvertible {

    /// debug description
    /// - Note:
    ///     将所有节点数据转换为 string 返回
    public var debugDescription: String {
        var desc = ""
        if size > 0 {
            for item in self.dropLast() {
                desc += "\(item)-->"
            }
            desc += "\(lastNode!.value)"
        }
        return desc
    }
}

