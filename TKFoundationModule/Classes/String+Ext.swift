//
//  String+Ext.swift
//  TKFoundationModule
//
//  Created by zhuamaodeyu on 01/24/2019.
//  Copyright (c) 2019 zhuamaodeyu. All rights reserved.
//
import Foundation


extension String : NamespaceWrappable{}
extension TypeWrapperProtocol where WrappedType == String {

    /// 随机字符串
    ///
    /// - Parameters:
    ///   - length: 长度
    ///   - espec: 是否带有特殊字符
    /// - Returns: 结果
   public static func randomString(length: Int,espec: Bool? = false) -> String {

        let  letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        if espec ?? false {
            letters.appending(",./;'[]!@#$%^&*()")
        }
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }
    
    
}
