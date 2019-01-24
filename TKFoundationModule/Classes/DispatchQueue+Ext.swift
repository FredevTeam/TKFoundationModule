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
