//
//  Namespace.swift
//  Pods-TKBaseModule_Example
//
//  Created by 聂子 on 2018/12/24.
//

import Foundation

///////////////////////////协议命名空间///////////////////////////////////
/// 命名空间协议  此处的tk 是类协议的
public protocol NamespaceWrappable {
    associatedtype WrapperType
    var tk: WrapperType { get }
    static var tk: WrapperType.Type { get }
}
public extension NamespaceWrappable {
    var tk: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }
    static var tk: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}

/// 此处的是object 对象的
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







