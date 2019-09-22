//
//  Data+Ext.swift
//  Pods-TKBaseModule_Example
//
//  Created by 聂子 on 2018/12/30.
//

import Foundation

extension Data:NamespaceWrappable{}
extension TypeWrapperProtocol where WrappedType == Data {
    
    /// 获取json 字符串
    ///
    /// - Parameter data: data
    /// - Returns: json string
   public func json() -> String? {
        do {
           let result =  try JSONSerialization.jsonObject(with: self.wrappedValue, options: .allowFragments)
            guard JSONSerialization.isValidJSONObject(result) else {
                return nil
            }
            let data  = try JSONSerialization.data(withJSONObject: result)
            return String(data: data, encoding: .utf8)
            
        } catch  {
            return nil
        }
    }
}


extension TypeWrapperProtocol where WrappedType == NSData {
    
    /// 获取 image 类型
    ///
    /// - Returns: 类型
    public func imageType() -> String? {
        var c:UInt8?
        self.wrappedValue.getBytes(&c, length: 1)
        switch c {
        case 0xFF:
            
            return ".jpeg"
            
        case 0x89:
            
            return ".png"
            
        case 0x47:
            
            return ".gif"
            
        case 0x49:
            fallthrough
        case 0x4D:
            
            return ".tiff"
        default:
            break
        }
        return nil
    }
}
