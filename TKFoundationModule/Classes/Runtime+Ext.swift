//
//  Runtime+Ext.swift
//  Pods-TKBaseModule_Example
//
//  Created by 聂子 on 2018/12/28.
//

import Foundation


// MARK: - NSObject
extension TypeWrapperProtocol where WrappedType == NSObject {
    
    /// 获取类的实例方法名
    ///
    /// - Parameters:
    ///   - debug: 是否开发模式 会控制台打印方法名
    ///   - `class`: 类
    /// - Returns: 方法名数组
    public func getMethodNames(debug: Bool,`class`: AnyClass?) -> [String] {
        var count:UInt32 = 0
        var names = [String]()
        var targetClass: AnyClass? = `class`
        if targetClass == nil  {
            targetClass = self.wrappedValue.classForCoder
        }
        //        UnsafeMutablePointer<objc_property_t>
        let methods = class_copyMethodList(`class`, &count)
        if methods == nil {
            return names
        }
        for i  in 0...(Int(count) - 1) {
            let aMet: objc_property_t = methods![i]
            let string = String(utf8String: property_getName(aMet))
            names.append(string!)
            if debug {
                debugPrint(string ?? "")
            }
        }
        return names
    }
    
    /// 获取所有类方法名
    ///
    /// - Parameters:
    ///   - debug: 是否开发模式 会控制台打印方法名
    ///   - `class`: 类
    /// - Returns: 方法名数组
    public func getClassMethodNames(debug: Bool,`class`: AnyClass?) -> [String] {
        var count:UInt32 = 0
        var names = [String]()
        var targetClass: AnyClass? = `class`
        if targetClass == nil  {
            targetClass = self.wrappedValue.classForCoder
        }
        //        UnsafeMutablePointer<objc_property_t>
        let methods = class_copyMethodList(object_getClass(`class`), &count)
        if methods == nil {
            return names
        }
        for i  in 0...(Int(count) - 1) {
            let aMet: objc_property_t = methods![i]
            let string = String(utf8String: property_getName(aMet))
            names.append(string!)
            if debug {
                debugPrint(string ?? "")
            }
        }
        return names
    }
    
    
    /// 获取所有的属性列表
    ///
    /// - Parameters:
    ///   - debug: 是否开发模式
    ///   - `class`: 类对象
    /// - Returns: 结果 属性列表
    public func getPropertyList(debug: Bool,`class`: AnyClass?) -> [String] {
        var names = [String]()
        var count: UInt32 = 0
        
        var targetClass: AnyClass? = `class`
        if targetClass == nil  {
            targetClass = self.wrappedValue.classForCoder
        }
        
        let propertys = class_copyPropertyList(self.wrappedValue.classForCoder, &count)
        if  propertys == nil  {
            return names
        }
        for i  in 0...(Int(count) - 1) {
            let aMet: objc_property_t = propertys![i]
            let string = String(utf8String: property_getName(aMet))
            names.append(string!)
            if debug {
                debugPrint(string ?? "")
            }
        }
        return names
    }
    
    /// 协议列表
    ///
    /// - Parameters:
    ///   - debug: 开发模式
    ///   - `class`: 类
    /// - Returns: 协议名数组
    public func getProtocolNames(debug: Bool,`class`: AnyClass?) -> [String] {
        var names = [String]()
        var count: UInt32 = 0
        
        var targetClass: AnyClass? = `class`
        if targetClass == nil  {
            targetClass = self.wrappedValue.classForCoder
        }
        
        let `protocol` = class_copyProtocolList(self.wrappedValue.classForCoder, &count)
        
        if  `protocol` == nil  {
            return names
        }
        for i  in 0...(Int(count) - 1) {
            let aMet = `protocol`![i]
            let string = String(utf8String: protocol_getName(aMet))
            names.append(string!)
            if debug {
                debugPrint(string ?? "")
            }
        }
        return names
    }


    /// 方法列表
    ///
    /// - Parameters:
    ///   - debug: debug 模式， 会打印方法列表
    ///   - `class`: class
    /// - Returns: [String] 方法名数组
    public func getMethodList(debug: Bool,`class`: AnyClass?) -> [String] {
        var names = [String]()
        var count: UInt32 = 0

        var targetClass: AnyClass? = `class`
        if targetClass == nil  {
            targetClass = self.wrappedValue.classForCoder
        }

        let propertys = class_copyMethodList(self.wrappedValue.classForCoder, &count)
        if  propertys == nil  {
            return names
        }
        for i  in 0...(Int(count) - 1) {
            let aMet: objc_property_t = propertys![i]
            let string = String(utf8String: property_getName(aMet))
            names.append(string!)
            if debug {
                debugPrint(string ?? "")
            }
        }
        return names
    }
    
}
