//
//  DelayQueue.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/5/25.
//

import Foundation

public typealias QueueBlock = () -> Void

/// 延迟队列
/// - Note:
///     监听runloop ，当主线程空闲时执行某些操作
public class DelayQueue {

    /// shared
    /// - Note:
    ///     单利
    public static let shared = DelayQueue()
    private var queue = Queue<QueueBlock>()

    /// 队列最大容量
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
    /// - Note:
    ///     如果当前队列中未处理任务大于最大队列数， 那么将移除前置的任务，以添加新的任务
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
