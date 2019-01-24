//
//  Dcitionary+Ext.swift
//  TKBaseModule
//
//  Created by 聂子 on 2019/1/5.
//

import Foundation


extension TypeWrapperProtocol where WrappedType == Dictionary<String, Any> {
    
    /// sting
    ///
    /// - Parameters:
    ///   - name: key
    ///   - def: default value
    /// - Returns: value
    public func string(_ name:String, def: String?) -> String? {
        return self.wrappedValue[name] as? String ?? def
    }
    
    /// int
    ///
    /// - Parameters:
    ///   - name: key
    ///   - def: default value
    /// - Returns: value
    public func int(_ name: String, def:Int?) -> Int? {
        return self.wrappedValue[name] as? Int ?? def
    }
    
    /// double
    ///
    /// - Parameters:
    ///   - name: key
    ///   - def: default value
    /// - Returns: value
    public func double(_ name: String, def:Double?) -> Double? {
        return self.wrappedValue[name] as? Double ?? def
    }
    
    /// float
    ///
    /// - Parameters:
    ///   - name: key
    ///   - def: default value
    /// - Returns: value
    public func float(_ name: String, def:Float?) -> Float? {
        return self.wrappedValue[name] as? Float ?? def
    }
    
    /// bool
    ///
    /// - Parameters:
    ///   - name: key
    ///   - def: default value
    /// - Returns: value
    public func bool(_ name: String, def:Bool?) -> Bool? {
        return self.wrappedValue[name] as? Bool ?? def
    }
    
    /// bool
    ///
    /// - Parameters:
    ///   - name: key
    ///   - def: default value
    /// - Returns: value
    public func bool(_ name: String, def:Bool) -> Bool {
        return self.wrappedValue[name] as? Bool ?? def
    }
}
