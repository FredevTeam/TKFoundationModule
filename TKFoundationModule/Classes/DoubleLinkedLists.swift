//
//  DoubleLinkedLists.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/8/12.
//

import Foundation


public class DoubleLinkedListNode<V> {
    fileprivate(set) public var value: V
    fileprivate(set) public var next: DoubleLinkedListNode<V>?
    fileprivate(set) public var previous: DoubleLinkedListNode<V>?

    public init(_ value: V) {
        self.value = value
    }

    public init(_ value: V, next: DoubleLinkedListNode<V>? = nil , previous: DoubleLinkedListNode<V>? = nil) {
        self.value = value
        self.next = next
        self.previous = previous
    }
}


public final class DoubleLinkedList<V> {
    private var size = 0
    private var firstNode: DoubleLinkedListNode<V>?
    private var lastNode: DoubleLinkedListNode<V>?

    init() {
    }
}

extension DoubleLinkedList {
    public func append(_ newElement: V) {
        let node = DoubleLinkedListNode.init(newElement, next: nil, previous: lastNode)
        if lastNode == nil {
            firstNode = node
        }
        lastNode?.next = node
        lastNode = node
        size += 1
    }

    /// 追加多个元素
    public func append<S>(contentsOf newElements: S) where S : Sequence, V == S.Element {
        for item in newElements {
            append(item)
        }
    }
    /// 插入单个元素
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
    /// 插入多个元素
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

// MARK: - 实现Collection协议
extension DoubleLinkedList : Collection {
    /// 开始位置
    public var startIndex: Int {  return 0 }
    /// 结束位置
    public var endIndex: Int { return size }
    /// 给定位置后面的索引值
    public func index(after i: Int) -> Int {
        return i + 1
    }
    /// 返回指定的迭代器
    public func makeIterator() -> Iterator {
        return Iterator(self)
    }
    /// 通过下标存取元素
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
    public func remove(at position: Int) -> V {
        let removeNode = node(at: position)
        removeNode.previous?.next = removeNode.next
        removeNode.next?.previous = removeNode.previous
        size -= 1
        return removeNode.value
    }

    /// 删除第一个元素
    @discardableResult
    public func removefirstNode() -> V? {
        return firstNode == nil ? nil : remove(at: 0)
    }
    /// 删除最后一个元素
    @discardableResult
    public func removelastNode() -> V? {
        return lastNode == nil ? nil : remove(at: size - 1)
    }
    /// 删除所有元素
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
   public func firstIndex(where predicate: (V) throws -> Bool) rethrows -> Int? {
        for (index,item) in self.enumerated() {
            if try predicate(item) {
                return index
            }
        }
        return nil
    }

    /// 倒序查找
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
    public func firstIndex(of element: V) -> Int? {
        return firstIndex { (item) -> Bool in
            return item == element
        }
    }
    public func lastIndex(of element: V) -> Int? {
        return lastIndex(where: { (item) -> Bool in
            return item == element
        })
    }

    public func contains(_ element: V) -> Bool {
        return contains(where: { (item) -> Bool in
            return item == element
        })
    }

    public func find(by value: V) -> DoubleLinkedListNode<V>? {
        guard let index = firstIndex(of: value) else { return nil }
        return node(at: index)
    }

   public func removes(at: [V])  {
        at.forEach { (v) in
            guard let index = firstIndex(of: v) else { return }
            remove(at: index)
        }
    }
}
// MARK: - 把LinkedList转成Array
extension DoubleLinkedList {
   public func toArray() -> [V] {
        return self.map({ (item) -> V in
            return item
        })
    }
}


// MARK: - CustomDebugStringConvertible协议，通过实现该协议，实现自定义打印
extension DoubleLinkedList : CustomDebugStringConvertible {
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

