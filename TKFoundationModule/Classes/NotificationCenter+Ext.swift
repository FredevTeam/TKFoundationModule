//
//  NotificationCenter+Ext.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/5/25.
//

import Foundation


// MARK: - NSNotification Center
extension TypeWrapperProtocol where WrappedType == NotificationCenter {


    /// send notification
    ///
    /// - Parameters:
    ///   - name: notification name
    ///   - object: object default nil
    ///   - userInfo: userinfo default [:]
    public static func send(_ name: Notification.Name, object: Any? = nil , userInfo:[AnyHashable: Any]? = [:]) {
        self.WrappedType.default.post(name: name, object: object, userInfo: userInfo)
    }


    /// receive notification
    ///
    /// - Parameters:
    ///   - name: notification name
    ///   - instance:  target
    ///   - selector: selector
    public static func receive(_ name: Notification.Name, instance: Any, selector: Selector) {
        self.WrappedType.default.addObserver(instance, selector: selector, name: name, object: nil)
    }

}
