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
    
    
    /// 获取内容宽度
    ///
    /// - Parameters:
    ///   - font: 字体
    ///   - maximumNumberOfLines: 行数
    /// - Returns: 宽度
    func width(with font: UIFont, maximumNumberOfLines: Int = 0) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        return self.size(thatFits: size, font: font, maximumNumberOfLines: maximumNumberOfLines).width
    }
    
    /// 获取内容高度
    ///
    /// - Parameters:
    ///   - width: 宽度
    ///   - font: 字体
    ///   - maximumNumberOfLines: 行数
    /// - Returns: 高度
    func height(thatFitsWidth width: CGFloat, font: UIFont, maximumNumberOfLines: Int = 0) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return self.size(thatFits: size, font: font, maximumNumberOfLines: maximumNumberOfLines).height
    }
    
    
    /// 获取内容size
    ///
    /// - Parameters:
    ///   - size: size
    ///   - font: 字体
    ///   - maximumNumberOfLines: 行数
    /// - Returns: size
    func size(thatFits size: CGSize, font: UIFont, maximumNumberOfLines: Int = 0) -> CGSize {
        let attributes: [NSAttributedStringKey: Any] = [.font: font]
        var size = self.wrappedValue.boundingRect(with: size, attributes: attributes, context: nil).size
        if maximumNumberOfLines > 0 {
            size.height = min(size.height, CGFloat(maximumNumberOfLines) * font.lineHeight)
        }
        return size
    }
}
