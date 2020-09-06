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

// MARK: - Timer
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
    
//    public /*not inherited*/ init(timeInterval ti: TimeInterval, target aTarget: Any, selector aSelector: Selector, userInfo: Any?, repeats yesOrNo: Bool)

//    open class func scheduledTimer(timeInterval ti: TimeInterval, target aTarget: Any, selector aSelector: Selector, userInfo: Any?, repeats yesOrNo: Bool) -> Timer

//    /// init(fireAt date: Date, interval ti: TimeInterval, target t: Any, selector s: Selector, userInfo ui: Any?, repeats rep: Bool)
//    /// - Parameters:
//    ///   - date: date description
//    ///   - ti: ti description
//    ///   - t: t description
//    ///   - s: s description
//    ///   - ui: ui description
//    ///   - rep: rep description
//    public static func timer(fireAt date: Date, interval ti: TimeInterval, target t: Any, selector s: Selector, userInfo ui: Any?, repeats rep: Bool) -> Timer{
//        let timer = Timer.init(fireAt: date, interval: ti, target: TProxy.proxyWith(target: t), selector: s, userInfo: ui, repeats: rep)
//        return timer
//    }
//
//    public static func timer(timeInterval ti: TimeInterval, target aTarget: Any, selector aSelector: Selector, userInfo: Any?, repeats yesOrNo: Bool) ->Timer {
//        let timer = Timer.init(timeInterval: ti, target: TProxy.proxyWith(target: aTarget), selector: aSelector, userInfo: userInfo, repeats: yesOrNo)
//        return timer;
//    }
//
//    public static func scheduledTimer(timeInterval ti: TimeInterval, target aTarget: Any, selector aSelector: Selector, userInfo: Any?, repeats yesOrNo: Bool) -> Timer {
//        let timer = Timer.scheduledTimer(timeInterval: ti, target: TProxy.proxyWith(target: aTarget), selector: aSelector, userInfo: userInfo, repeats: yesOrNo)
//        return timer;
//    }
//
    
    
}


//class TProxy: NSObject {
//    weak var target:NSObjectProtocol?
//    static func proxyWith(target:NSObjectProtocol) -> TProxy {
//        let proxy = TProxy.init();
//        proxy.target = target;
//        return proxy;
//    }
//    override class func responds(to aSelector: Selector!) -> Bool {
//        return self.
//    }
//}
//





