//
//  Sequence+Ext.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/2/17.
//

import Foundation

extension Sequence {
    
    /// forEach
    ///
    /// - Parameter block: block
    /// - Throws: throws
    public func forEach(_ block: (Element, _ stop: inout Bool) throws -> Void) rethrows {
        var stop = false
        for e in self {
            try block(e, &stop)
            if stop {
                return
            }
        }
    }
}


extension Sequence where Element : Equatable {
    /// 去重
    ///
    /// - Returns: 新数组
    public func removeDuplicates() -> [Element] {
        return self.reduce([], { $0.contains($1) ? $0 : $0 + [$1] })
    }
}

extension Sequence {

    /// 排序
    ///
    /// - Parameter att: 排序条件
    /// - Returns: 排序后结果
    public func sort<T: Comparable>(by att: KeyPath<Element, T>) -> [Element] {
        return sorted(by: { $0[keyPath: att] < $1[keyPath: att] })
    }
}

// MARK:- Collection
extension Collection {
    var isNotEmpty: Bool {
        return !isEmpty
    }

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

