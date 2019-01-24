//
//  SwizzingMethod.swift
//  Pods-TKBaseModule_Example
//
//  Created by 聂子 on 2018/12/24.
//

import Foundation

/// 方法交换协议
protocol SwizzingProtocol: class {
    static func awake()
    
    /// 方法交换
    ///
    /// - Parameters:
    ///   - forClass: 目标类
    ///   - originalSelector: 原始方法
    ///   - swizzledSelector: 目标方法
    static func swizzling(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector)
    static func swizzling(_ forDelegate: NSObjectProtocol, originalSel: Selector,targetClass:AnyClass, targetSel:Selector,defaultMethod:Method?)
}
extension SwizzingProtocol {
    
    static func swizzling(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(forClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
        
        guard (originalMethod != nil && swizzledMethod != nil) else {
            return
        }
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
    
    
    
    /// 交换代理方法
    ///
    /// - Parameters:
    ///   - delegate: 代理  delegate  UITableViewDelegate
    ///   - originalSel: 原始代理方法 #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))
    ///   - targetClass: 目标类 UITableView.self
    ///   - targetSel: 目标方法 #selector(UITableView.tk_tableView(_:didSelectRowAt:))
    ///   - defaultMethod: 代理方式未实现时，默认实现   class_getInstanceMethod(UITableView.self, #selector(UITableView.defaultMethod))
    static func swizzling(_ delegate: NSObjectProtocol, originalSel: Selector,targetClass:AnyClass, targetSel:Selector,defaultMethod:Method?) {
        var originalMethod = class_getInstanceMethod(type(of: delegate), originalSel)
        let swizzledMethod = class_getInstanceMethod(targetClass, targetSel)
        
        //            let result = class_addMethod(type(of: delegate), originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        var `default` = defaultMethod
        if `default` == nil  {
            `default` = class_getInstanceMethod(NSObject.self, #selector(NSObject.defaultMethod))
        }
        // imp <--- sel
        let result = class_addMethod(type(of: delegate), originalSel, method_getImplementation(`default`!), method_getTypeEncoding(`default`!))
        if result {
            originalMethod = class_getInstanceMethod(type(of: delegate), originalSel)
            //             class_replaceMethod(type(of: delegate), swizzleSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        }
        method_exchangeImplementations(originalMethod!, swizzledMethod!)
    }
}

extension NSObject {
    @objc func defaultMethod() {
        
    }
}

class SwizzingMethod {
    static func sendMessage() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SwizzingProtocol.Type)?.awake()
        }
        types.deallocate()
    }
}

extension UIApplication {
    private static let once: Void = {
        SwizzingMethod.sendMessage()
    }()
    override open var next: UIResponder? {
        UIApplication.once
        return super.next
    }
}
