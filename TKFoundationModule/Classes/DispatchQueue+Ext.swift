//
//  DispatchQueue+Ext.swift
//  TKBaseModule
//
//  Created by 聂子 on 2018/12/24.
//

import Foundation

private let mainQueueKey = DispatchSpecificKey<String>.init()
private let mainQueueValue = "mainQueue"


// MARK: - DispatchQueue
extension TypeWrapperProtocol where WrappedType == DispatchQueue {
    
    /// 判断是否在主线程执行推荐通过此方式来实现
    ///
    /// - Returns: 当前是否在主队列
    public static func  isMainQueue() -> Bool {
        DispatchQueue.main.setSpecific(key: mainQueueKey, value: mainQueueValue)
        return DispatchQueue.getSpecific(key: mainQueueKey) == mainQueueValue
    }
    
    
}


extension DispatchQueue {
    /// main
    ///
    /// - Parameter execute: block
    public static func main(execute: @escaping () -> Void) {
        DispatchQueue.main.async(execute: execute)
    }
    
    
    /// global
    ///
    /// - Parameter execute: block
    public static func global(execute: @escaping () -> Void) {
        DispatchQueue.global().async(execute: execute)
    }
    
    
    /// delay time
    ///
    /// - Parameters:
    ///   - time: time
    ///   - execute: block
    public static func delay(_ time: Double, execute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: execute)
    }   
}




/// synchronized
///  @synchronized
/// - Parameters:
///   - lock: lock description
///   - closure: closure block
/// - Returns: return value description
/// - Throws: throws value description
public func synchronized<T>(_ lock: AnyObject, _ closure: () throws -> T) rethrows -> T {
    objc_sync_enter(lock)
    defer { objc_sync_exit(lock) }
    return try closure()
}


