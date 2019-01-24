//
//  Optional+Ext.swift
//  Pods-TKBaseModule_Example
//
//  Created by 聂子 on 2018/12/24.
//
import Foundation

extension Optional {
    
    /// 判断是否为空 true
    var isNone: Bool {
        switch self  {
        case .none:
            return true
        case .some:
            return false
        }
    }
    
    
    /// 判断是否非空  true
    var  isNotNone: Bool {
        return !isNone
    }
    
    var readme: String? {
        return "此部分来源于，感谢SwiftGG翻译组, 感谢这些函数的实现者"
    }
}


extension Optional {
    
    /// 返回可选值或默认值
    ///
    /// - Parameter default: 可选值
    /// - Returns: 结果
    func or(_ default: Wrapped) -> Wrapped {
        return self ?? `default`
    }
    
    
    /// 返回可选值或 `else` 表达式返回结果
    ///
    /// - Parameter else: 表达式
    /// - Returns: 结果
    func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    
    /// 返回可选值或 `else` 必报返回值
    ///
    /// - Parameter else: 闭包
    /// - Returns: 结果
    func or(else: () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    
    /// 当可选值为不为空时，返回值； 为空时，抛出异常
    ///
    /// - Parameter exception: 异常
    /// - Returns: 结果
    /// - Throws: 异常
    func or(throw exception: Error) throws -> Wrapped {
        guard let unwrapped = self else { throw exception }
        return unwrapped
    }
}

extension Optional where Wrapped == Error {
    
    /// 当可选值不为空时，执行 `else`
    ///
    /// - Parameter else: 执行内容
    func or(_ else: (Error) -> Void) {
        guard let error = self else { return }
        `else`(error)
    }
}


extension Optional {
    
    ///
    ///
    /// - Parameter do: <#do description#>
    /// - Returns: <#return value description#>
    func should(_ do: () throws -> Void) -> Error? {
        do {
            try `do`()
            return nil
        } catch let error {
            return error
        }
    }
}


extension Optional {
    
    /// 可选值变换返回，可指定默认值
    ///
    /// - Parameters:
    ///   - fn: 映射闭包
    ///   - default: 默认值
    /// - Returns: 结果
    /// - Throws: 异常
    func map<T>(_ fn: (Wrapped) throws -> T, default: T) rethrows -> T {
        return try map(fn) ?? `default`
    }
    
    
    /// 可选值变换返回，如果为空，调用`else` 闭包
    ///
    /// - Parameters:
    ///   - fn: 映射闭包
    ///   - else: 执行闭包
    /// - Returns: 结果
    /// - Throws: 异常
    func map<T>(_ fn: (Wrapped) throws -> T, else: () throws -> T) rethrows -> T {
        return try map(fn) ?? `else`()
    }
}



extension Optional {
    
    /// 当可选值不为空时，解包返回参数  `optional`
    ///
    /// - Parameter optional: 参数
    /// - Returns: 结果
    func and<B>(_ optional: B?) -> B? {
        guard self != nil else { return nil }
        return optional
    }
    
    /// 解包可选值，当可选值不为空时，执行 `then` 闭包，并返回执行结果
    /// 允许你将多个可选项连接在一起
    func and<T>(then: (Wrapped) throws -> T?) rethrows -> T? {
        guard let unwrapped = self else { return nil }
        return try then(unwrapped)
    }
    
    /// 将当前可选值与其他可选值组合在一起
    /// 当且仅当两个可选值都不为空时组合成功，否则返回空
    func zip2<A>(with other: Optional<A>) -> (Wrapped, A)? {
        guard let first = self, let second = other else { return nil }
        return (first, second)
    }
    
    /// 将当前可选值与其他可选值组合在一起
    /// 当且仅当三个可选值都不为空时组合成功，否则返回空
    func zip3<A, B>(with other: Optional<A>, another: Optional<B>) -> (Wrapped, A, B)? {
        guard let first = self,
            let second = other,
            let third = another else { return nil }
        return (first, second, third)
    }
    

}

extension Optional {
    /// 当可选值不为空时，执行 `some` 闭包
    func on(some: () throws -> Void) rethrows {
        if self != nil { try some() }
    }
    
    /// 当可选值为空时，执行 `none` 闭包
    func on(none: () throws -> Void) rethrows {
        if self == nil { try none() }
    }
}

extension Optional {
    /// 可选值不为空且可选值满足 `predicate` 条件才返回，否则返回 `nil`
    func filter(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let unwrapped = self,
            predicate(unwrapped) else { return nil }
        return self
    }
    
    /// 可选值不为空时返回，否则 crash
    func expect(_ message: String) -> Wrapped {
        guard let value = self else { fatalError(message) }
        return value
    }
}










