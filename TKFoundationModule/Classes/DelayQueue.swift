//
//  DelayQueue.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/5/25.
//

import Foundation

public typealias QueueBlock = () -> Void
public class DelayQueue {
    public static let shared = DelayQueue()
    private var queue = Queue<QueueBlock>()

    public var queueMaxCount:Int = 20

    private init() {
        initRunloop()
    }
}

extension DelayQueue {
    private func initRunloop() {
        let runloop = CFRunLoopGetMain()
        let activities = CFRunLoopActivity.beforeWaiting.rawValue & CFRunLoopActivity.afterWaiting.rawValue
        let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, activities, true, Int.max) { [weak self](observer, activity) in
            switch activity {
            case CFRunLoopActivity.beforeWaiting:
                // TODO: idle
                while (self?.queue.size ?? 0) > 0 {
                    self?.queue.leave()?()
                }
                break
            case CFRunLoopActivity.afterWaiting:
                // TODO : runing
                break
            default:
                break
            }
        }
        CFRunLoopAddObserver(runloop, observer, CFRunLoopMode.defaultMode)
    }
}

extension DelayQueue {

    /// 添加
    ///
    /// - Parameter block: block
    public func add(block:@escaping QueueBlock) {
        if self.queue.size > queueMaxCount {
          _ = self.queue.leave()
        }
        self.queue.enter(block)
    }

    /// 清除所有的
    public func clearAll() {
        self.queue.removeAll()
    }
}
