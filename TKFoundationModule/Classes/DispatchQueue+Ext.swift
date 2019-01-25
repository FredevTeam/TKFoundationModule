//
//  DispatchQueue+Ext.swift
//  TKBaseModule
//
//  Created by 聂子 on 2018/12/24.
//

import Foundation

private let mainQueueKey = DispatchSpecificKey<String>.init()
private let mainQueueValue = "mainQueue"


extension TypeWrapperProtocol where WrappedType == DispatchQueue {
    
    /// 判断是否在主线程执行推荐通过此方式来实现
    ///
    /// - Returns: 当前是否在主队列
    static public  func  isMainQueue() -> Bool {
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
