//
//  NSObject+Ext.swift
//  Pods-TKBaseModule_Example
//
//  Created by 聂子 on 2018/12/24.
//

import Foundation

extension NSObject : NamespaceWrappable{}

// MARK: - NSObject Method Swizzing
extension TypeWrapperProtocol where WrappedType: NSObject {
    
    /// 方法交换
    ///
    /// - Parameters:
    ///   - cls: 目标对象
    ///   - originalSelector: 原方法
    ///   - swizzleSelector: 交换方法
   public static func swizzleMethod(_ cls: AnyClass, originalSelector: Selector, swizzleSelector: Selector){
        
        let originalMethod = class_getInstanceMethod(cls, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(cls, swizzleSelector)!
        let didAddMethod = class_addMethod(cls,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(cls,
                                swizzleSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}


// MARK: - NSObject run time
extension  TypeWrapperProtocol where WrappedType: NSObject {
    
    /// 执行时间
    ///
    /// - Parameters:
    ///   - executions: 次数
    ///   - block: block
    /// - Returns: 平均时间
    public func time(executions: Int = 1, _ block: () -> Void) -> TimeInterval {
        let start  = Date()
        for _ in 0..<executions {
            block()
        }
        let end = Date()
        let duration = end.timeIntervalSince(start) / Double(executions)
        return duration
    }
 
}

