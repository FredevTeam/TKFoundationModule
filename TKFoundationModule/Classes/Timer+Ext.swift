//
//  Timer+Ext.swift
//  TKBaseModule
//
//  Created by 聂子 on 2018/12/24.
//

import Foundation

extension Timer {
    
    @objc fileprivate func invokeBlock(timer: Timer) {
        let block:((_ timer:Timer) -> Void)? = timer.userInfo as? ((Timer) -> Void)
        block?(timer)
    }
}

extension TypeWrapperProtocol where WrappedType == Timer {
    /// 解决内存泄漏的问题
    ///
    /// - Parameters:
    ///   - interval: <#interval description#>
    ///   - repoats: <#repoats description#>
    ///   - block: <#block description#>
    /// - Returns: <#return value description#>
    @discardableResult
   public func  scheduledTimerWithTimerInterval(interval:TimeInterval,
                                                repoats: Bool,
                                                 block:@escaping ((_ timer:Timer)-> Void)) -> Timer {
    
    let timer = Timer.scheduledTimer(timeInterval: interval, target: self.wrappedValue, selector: #selector(self.wrappedValue.invokeBlock(timer:)), userInfo: ["block":block], repeats: repoats)
    return timer
    }
    

}
