//
//  Timer+Ext.swift
//  TKBaseModule
//
//  Created by 聂子 on 2018/12/24.
//

import Foundation

extension Timer {
}
class Block<T> {
    let f : T
    init(_ f: T) { self.f = f }
    
    @objc func invokeBlock(_ timer: Timer) {
        if let block = timer.userInfo as? Block<(Timer) -> Swift.Void> {
            block.f(timer)
        }
    }
}
extension TypeWrapperProtocol where WrappedType == Timer {

    /// 解决内存泄漏的问题
    ///
    /// - Parameters:
    ///   - interval: 时间间隔
    ///   - repoats: 是否循环
    ///   - block: 回调block
    /// - Returns: Timer object 
    @discardableResult
    public static func scheduledTimerWithTimerInterval(interval:TimeInterval,
                                                repeats: Bool,
                                                 block:@escaping ((_ timer:Timer)-> Void)) -> Timer {
        if #available(iOS 10.0, *) {
            return Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: block)
        }
        let block = Block(block)
       return Timer.scheduledTimer(timeInterval: interval, target: block, selector: #selector(block.invokeBlock(_:)), userInfo: block, repeats: repeats)
    }
}
