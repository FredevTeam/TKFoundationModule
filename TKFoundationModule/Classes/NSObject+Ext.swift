//
//  NSObject+Ext.swift
//  Pods-TKBaseModule_Example
//
//  Created by 聂子 on 2018/12/24.
//

import Foundation

extension NSObject : NamespaceWrappable{}
extension TypeWrapperProtocol where WrappedType == NSObject {
    
    /// 方法交换
    ///
    /// - Parameters:
    ///   - cls: 目标对象
    ///   - originalSelector: 原方法
    ///   - swizzleSelector: 交换方法
   public static func swizzleMethod(_ cls: AnyClass, originalSelector: Selector, swizzleSelector: Selector){
        
        let originalMethod = class_getInstanceMethod(cls, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(cls, swizzleSelector)!
        let didAddMethod = class_addMethod(cls,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(cls,
                                swizzleSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}

extension  TypeWrapperProtocol where WrappedType == NSObject {
    
    
    /// 获取view 所在的控制器
    ///
    /// - Parameter view: <#view description#>
    /// - Returns: <#return value description#>
    func viewController(view: UIView?) -> UIViewController? {
        var next: UIResponder? = view?.next
        repeat {
            if (next as? UIViewController) != nil  {
                return next as? UIViewController
            }else {
                next = next?.next
            }
        }while next != nil
        return nil
    }
    
    /// 获取栈结构
    ///
    /// - Parameter vc: <#vc description#>
    /// - Returns: <#return value description#>
    func stackViewControllers(vc: UIViewController) -> [UIViewController] {
        var stack:[UIViewController] = []
        stack.append(vc)
        var next: UIResponder? = vc.next
        repeat {
            if (next as? UIViewController) != nil  {
                stack.insert(next as! UIViewController, at: 0)
            }else {
                next = next?.next
            }
        }while next != nil
        return stack
    }
}
