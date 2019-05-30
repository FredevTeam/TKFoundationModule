//
//  Array+Ext.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/1/26.
//

import Foundation

public struct ArrayProxy<Element>{
    let base : Array<Element>
    init(proxy: Array<Element>) {
        base = proxy
    }
}
extension Array: NamespaceWrappable{
    public var ns: ArrayProxy<Element> {
        return ArrayProxy(proxy: self)
    }
    public static var ns: ArrayProxy<Element>.Type {
        return ArrayProxy.self
    }
}


extension Array {
    
    /// 解决数组越界问题
    /// array[safe: 1]
    /// - Parameter index: index
   public subscript(safe index: Index) -> Element? {
        return self.count > index ? self[index] : nil
    }
}


extension ArrayProxy {
    
   /// 任意元素
   public var random: Element? {
        if base.isEmpty {
            return nil}
        let index: Int = Int(arc4random_uniform(UInt32(base.count)))
        return base[index]
    }
    
    
    /// sub array
    ///
    /// - Parameter index: to index
    /// - Returns: sub array
    public func subArray(to index:Int) -> [Element]? {
        if base.isEmpty || base.count < index {
            return nil
        }
        var sub = [Element]()
        for i  in 0...index {
            sub.append(base[i])
        }
        return sub
    }
    
    /// sub array
    ///
    /// - Parameters:
    ///   - index: from
    ///   - to: to
    /// - Returns: sub array
    public func subArray(from index:Int, to:Int) -> [Element]?{
        if base.isEmpty {
            return nil
        }
        if index > to {
            return nil
        }
        
        if index > base.count || to < 0 || to > base.count {
            return nil
        }
        
        var sub = [Element]()
        for i in index...to {
            sub.append(base[i])
        }
        return sub
    }
    
    /// 下标操作
    ///
    /// - Parameter index: 下标
    public subscript(safe index: Int) -> Element? {
        return index >= 0 && index < base.count ? base[index] : nil
    }
    
    
    /// 随机排序(乱序)
    ///
    /// - Returns: 结果
    public func shuffle() -> [Element] {
        var list = base
        for index in 0..<list.count {
            let newIndex = Int(arc4random_uniform(UInt32(list.count-index))) + index
            if index != newIndex {
                list.swapAt(index, newIndex)
            }
        }
        return list
    }
}

extension ArrayProxy where Element : Equatable {
    
    /// 查找
    ///
    /// - Parameter fn:  block
    /// - Returns: result
    public func find(fn: (Element?) -> Bool) -> [Element] {
        var to = [Element]()
        for item  in base {
            if fn(item){
                to.append(item)
            }
        }
        return to
    }
    /// next
    ///
    /// - Parameter ele: item
    /// - first : default return first item
    /// - Returns: next element
    public func nextOf(_ ele: Element?, first: Bool = false) -> Element? {
        guard let index = base.index(where: {$0 == ele}) else {
            return nil
        }
        return index < (base.count - 1) ? base[index + 1] : (first ? base.first : nil)
    }
    
    
    /// contains 包含
    ///
    /// - Parameter items: 元素
    /// - Returns: 结果
    public func contains(items:Element...) -> Bool {
        for i in items {
            if !self.base.contains(i) {
                return false
            }
        }
        return true
    }
    
    
    /// 查找
    ///
    /// - Parameter item: item
    /// - Returns: item
    public func find(item:Element) -> Element? {
        if let index = base.index(of: item) {
            return base[index]
        }
        return nil
    }
    
    
    /// 查找 index
    ///
    /// - Parameter condition: block
    /// - Returns: index
    public func index(of condition:(Element) -> Bool) -> Int? {
        for (index, element ) in base.enumerated() {
            if condition(element) {
                return index
            }
        }
        return nil
    }
    
    
    /// 遍历
    ///
    /// - Parameter condition: block
    public func each(condition:(Int, Element)->Void) {
        for (index, element ) in base.enumerated() {
            condition(index, element)
        }
    }
    
    
    /// check
    ///
    /// - Parameter condition: block
    /// - Returns: result
    public func check(condition:(Element) -> Bool) -> Bool {
        for item in base {
            if !condition(item) {
                return false
            }
        }
        return true
    }
    
    
    /// 个数
    ///
    /// - Parameter condition: block
    /// - Returns: 个数
    public func count(condition:(Element)-> Bool) -> Int {
        var count:Int = 0
        for item  in base {
            if condition(item) {
                count += 1
            }
        }
        return count
    }
    
    
    
    /// array -----> dictionary
    ///numberArray.ns.dictionary(transform: { (i) -> (key: String, value: Int)? in
    /// if i > 5 {
    ///     return (key: "1", value: i)
    /// }
    ///     return (key: "2", value: i)
    ///})
    ///
    ///
    /// - Parameter transform: block , Key 需要改为具体类型
    /// - Returns: dictionary (key:Key, value: Element)
    public func dictionary<Key:Hashable>(transform:(Element) -> (key:Key, value: Element)?) -> [Key: [Element]] {
        var result : [Key: [Element]] = [:]
        for  item  in base {
            if let t = transform(item) {
                if var value = result[t.key] {
//                if var value = result[t.key] {
                    value.append(t.value)
                    result.updateValue(value, forKey: t.key)
                }else {
                    result.updateValue([t.value], forKey: t.key)
                }
            }
        }
        return result
    }
    
    
    /// 并行执行
    ///
    /// - Parameter transform: block
    /// - Returns: result 数组
    public func sync<T>(_ transform: (Element) -> T) -> [T] {
        let count = base.count
        // 内存地址
        let s = UnsafeMutablePointer<T>.allocate(capacity: count)
        DispatchQueue.concurrentPerform(iterations: count) { (i) in
            s[i] = transform(base[i])
        }
        let result = Array<T>(UnsafeBufferPointer(start: s, count: count))
        s.deallocate()
        return result
    }
}




// MARK: -  && ||
extension ArrayProxy where Element : Equatable {

    /// 合集
    ///
    /// - Parameter items:  target array
    /// - Returns: result
    public func intersect(items: Element...) -> [Element] {
        var array = [Element]()
        self.base.forEach { (element) in
            if items.contains(element) {
                array.append(element)
            }
        }
        return array
    }


    /// 差集
    ///
    /// - Parameter items: target array
    /// - Returns: result
    public func difference(items: Element...) -> [Element] {
        var array = [Element]()
        self.base.forEach { (element) in
            if !items.contains(element) {
                array.append(element)
            }
        }
        return array
    }
}
