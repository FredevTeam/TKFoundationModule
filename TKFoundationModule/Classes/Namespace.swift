//
//  Namespace.swift
//  Pods-TKBaseModule_Example
//
//  Created by 聂子 on 2018/12/24.
//

import Foundation

///////////////////////////协议命名空间///////////////////////////////////
/// 命名空间协议  只需要更改其内部的命名空间名
public protocol NamespaceWrappable {
    associatedtype WrapperType
    var ns: WrapperType { get }
    static var ns: WrapperType.Type { get }
}
public extension NamespaceWrappable {
    var ns: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }
    static var ns: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}

/// 类型协议  固定写法
public protocol TypeWrapperProtocol {
    associatedtype WrappedType
    var wrappedValue: WrappedType { get }
    init(value: WrappedType)
}

public struct NamespaceWrapper<T>: TypeWrapperProtocol {
    public let wrappedValue: T
    public init(value: T) {
        self.wrappedValue = value
    }
}







