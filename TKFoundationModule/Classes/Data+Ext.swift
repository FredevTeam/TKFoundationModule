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
