//
//  String+Ext.swift
//  TKFoundationModule
//
//  Created by zhuamaodeyu on 01/24/2019.
//  Copyright (c) 2019 zhuamaodeyu. All rights reserved.
//
import Foundation

extension String : NamespaceWrappable{}

// MARK: - String
extension TypeWrapperProtocol where WrappedType == String {

    /// 随机字符串
    ///
    /// - Parameters:
    ///   - length: 长度
    ///   - espec: 是否带有特殊字符
    ///   - Example:
    ///         let string = String.ns.randomString(length:5, espec: true)
    /// - Returns: 结果
   public static func randomString(length: Int,espec: Bool = false) -> String {

        let  letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        if espec {
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
/// MARK: - String Size 
extension TypeWrapperProtocol where WrappedType == String {


    /// 获取内容宽度
    ///
    /// - Parameters:
    ///   - font: 字体
    ///   - maximumNumberOfLines: 行数
    /// - Returns: 宽度
    func width(with font: Font, maximumNumberOfLines: Int = 0) -> CGFloat {
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
    func height(thatFitsWidth width: CGFloat, font: Font, maximumNumberOfLines: Int = 0) -> CGFloat {
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
    func size(thatFits size: CGSize, font: Font, maximumNumberOfLines: Int = 0) -> CGSize {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        var size = self.wrappedValue.boundingRect(with: size, attributes: attributes, context: nil).size
        if maximumNumberOfLines > 0 {
            #if os(macOS)
            //             ceilf(self.ascender + ABS(self.descender) + self.leading);
            let lineHeight = ceilf(Float(font.ascender + CGFloat(abs(font.descender)) + font.leading))
            size.height = min(size.height, CGFloat(Float(maximumNumberOfLines) * lineHeight))
            #else
            size.height = min(size.height, CGFloat(maximumNumberOfLines) * font.lineHeight)
            #endif

        }
        return size
    }


}


/// MARK: - Type Conversion
extension TypeWrapperProtocol where WrappedType == String {


    /// to Float
    public var floatValue: Float {
        return (self.wrappedValue as NSString).floatValue
    }
    
    /// To int32
    public var intValue: Int32 {
        return (self.wrappedValue as NSString).intValue
    }
    
    /// to double
    public var doubleValue:Double {
        return (self.wrappedValue as NSString).doubleValue
    }
    
    /// to bool
    public var boolValue: Bool {
        return (self.wrappedValue as NSString).boolValue
    }

    /// to integer
    public var integerValue: Int {
        return (self.wrappedValue as NSString).integerValue
    }
    
    /// longlong
    public var longlongValue: Int64 {
        return (self.wrappedValue as NSString).longLongValue
    }
    
}




/// MARK: - html
extension TypeWrapperProtocol where WrappedType == String {
    // TODO - 颜色设置不对
    /// html -> NSAttributedString
    ///
    /// - Parameters:
    ///   - fontName: 字体名字
    ///   - size: 字体大小
    ///   - color: 字体颜色
    /// - Returns: 结果
    public func htmlAttributed(attributed fontName: String, size: CGFloat, color: Color) -> NSAttributedString? {
        let htmlString = "<style>" +
            "html *" +
            "{" +
            "font-size: \(size)pt !important;" +
            "color: #\(hex(color: color)) !important;" +
            "font-family: \(fontName), Helvetica !important;" +
        "}</style> \(self.wrappedValue)"

        guard let data = htmlString.data(using: .utf8) else {
            return nil
        }
       return try? NSAttributedString.init(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                      .characterEncoding: String.Encoding.utf8.rawValue],
                                documentAttributes: nil)
    }
    
    
    
    fileprivate func hex(color: Color ) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
    
    /// html Attributed
    public var htmlAttributed: NSAttributedString? {
        guard let data = self.wrappedValue.data(using: .utf8) else {
            return nil
        }
        return try? NSAttributedString(data: data,
                                       options: [.documentType: NSAttributedString.DocumentType.html,
                                                 .characterEncoding: String.Encoding.utf8.rawValue],
                                       documentAttributes: nil)
    }
}




/// MARK: - to  pingyin
extension TypeWrapperProtocol where WrappedType == String {
    /// 中文 -----> 拼音
    ///
    /// - Parameter stripDiacritics: 是否去除音标 default false
    /// - Returns: 拼音
    public func pinyin(stripDiacritics: Bool = false) -> String {
        let mutableString = NSMutableString(string: self.wrappedValue)
        // 转拼音
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        if stripDiacritics {
            CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        }
        return String(mutableString)
    }
}




/// MARK: - Length and text number
extension TypeWrapperProtocol where WrappedType == String {
    
    /// 获取字节长度
    ///
    /// - Returns: 字节长度
    public func byteLenght() -> Int {
        var bytes: [UInt8] = []
        for char in self.wrappedValue.utf8 {
            bytes.append(char.advanced(by: 0))
        }
        return bytes.count
    }
    
    
    /// 字数
    ///
    /// - Note:
    ///       转换为 utf-8 编码进行计算
    /// - Returns: text number
    public func number() -> Int {
        var bytes: [UInt8] = []
        for char in self.wrappedValue.utf8 {
            bytes.append(char.advanced(by: 0))
        }
        return (bytes.count + 1) / 2
    }
}




extension TypeWrapperProtocol where WrappedType == String {

    /// split string
    ///
    /// - Parameters:
    ///   - char: char description 间隔字符
    ///   - spacing: spacing description 间隔数
    ///   - Note:
    ///     文字个数会改变
    /// - Returns: return value description
    public func split(_ char: String = " ", _ spacing: Int) -> String? {
        if self.wrappedValue.isEmpty {
            return self.wrappedValue
        }

        let rem = self.wrappedValue.count % spacing
        let frequency = Int(self.wrappedValue.count / spacing)

        var text  = ""
        var currentIndex = self.wrappedValue.startIndex
        for _  in 0..<frequency {
            let maxIndex = self.wrappedValue.index(currentIndex, offsetBy: spacing)
            text = text + self.wrappedValue[currentIndex ..< maxIndex] + char
            currentIndex = maxIndex
        }

        let lastIndex = self.wrappedValue.index(currentIndex, offsetBy: rem)
        text += self.wrappedValue[currentIndex ..< lastIndex]
        return text.trimmingCharacters(in: .whitespaces)
    }



    /// split
    ///

    /// - Parameters:
    ///   - interval: 间隔数
    ///   - distance: 间隔l距离
    /// - Note:
    ///         分割，但是 文字个数不变，改变字体间间距
    /// - Example:
    ///     "ssjjs" ---> "s s j j s", length  = 5
    /// - Returns: return value description
    public func split(interval:Int = 3, separated distance:Int = 10) -> NSAttributedString? {
        let attS = NSMutableAttributedString.init(string: self.wrappedValue)

        for (index, _) in self.wrappedValue.enumerated() {
            if (index % interval == 0) && index > 0 {
                attS.addAttribute(NSAttributedString.Key.kern, value: distance, range: NSRange.init(location: index - 1, length: 1))
            }
        }
        return attS
    }
}




/// MARK: - Sub String
extension TypeWrapperProtocol where WrappedType == String {

    /// 子字符串
    ///
    /// - Parameter index: 索引位置
    /// - Note:
    ///     0 ... to index
    /// - Returns: 字符串
    public func sub(to index: UInt) -> String? {
        guard self.wrappedValue.isEmpty else {
            return self.wrappedValue
        }
         return String(self.wrappedValue[..<self.wrappedValue.index(self.wrappedValue.startIndex, offsetBy: min(Int(index), self.wrappedValue.count))])
    }

    /// 子字符串
    ///
    /// - Parameter index: 索引位置
    /// - Note:
    ///     from index .... last index
    /// - Returns: 子字符串
    public func sub(from index: UInt) -> String? {
        guard self.wrappedValue.isEmpty else {
            return self.wrappedValue
         }
         return String(self.wrappedValue[self.wrappedValue.index(self.wrappedValue.startIndex, offsetBy: min(Int(index), self.wrappedValue.count))...])
    }


    /// 子字符串
    ///
    /// - Parameters:
    ///   - start: 开始索引
    ///   - end: 结束索引
    /// - Returns: 子字符串
    public func sub(from start:UInt , to end:UInt) -> String? {
        if start > end {
            debugPrint("start Must be less than end")
            return nil
        }
        let startIndex = self.wrappedValue.index(self.wrappedValue.startIndex, offsetBy: min(Int(start), self.wrappedValue.count))
        let endIndex = self.wrappedValue.index(self.wrappedValue.endIndex, offsetBy: -(max(0, self.wrappedValue.count - Int(end))))
//        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
//        let start = index(startIndex, offsetBy: range.lowerBound)
//        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self.wrappedValue[startIndex ..< endIndex])
    }
}






/// MARK: - Find
extension TypeWrapperProtocol where WrappedType == String {

    /// 正则表达式查找
    ///
    /// - Parameter regex: 正则表达式
    /// - Returns: 结果数组
    public func findMatches(forRegex regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self.wrappedValue, options: [], range: NSRange.init(self.wrappedValue.startIndex..., in: self.wrappedValue))
            return results.map {
                String(self.wrappedValue[Range($0.range, in: self.wrappedValue)!])
            }
        } catch {
            print("Regex error: \(error)")
            return []
        }
    }
}



/// MARK: - Index
extension TypeWrapperProtocol where WrappedType == String {
    public func startIndex(of string: String, options: String.CompareOptions = .literal) -> String.Index? {
        return wrappedValue.range(of: string, options: options)?.lowerBound
    }
    public func endIndex(of string: String, options: String.CompareOptions = .literal) -> String.Index? {
        return wrappedValue.range(of: string, options: options)?.upperBound
    }
    public func indexes(of string: String, options: String.CompareOptions = .literal) -> [String.Index] {
        var result: [String.Index] = []
        var start = wrappedValue.startIndex
        while let range = wrappedValue.range(of: string, options: options, range: start..<wrappedValue.endIndex) {
            result.append(range.lowerBound)
            start = range.lowerBound < range.upperBound ? range.upperBound : wrappedValue.index(range.lowerBound, offsetBy: 1, limitedBy: wrappedValue.endIndex) ?? wrappedValue.endIndex
        }
        return result
    }
    public func ranges(of string: String, options: NSString.CompareOptions = .literal) -> [Range<String.Index>] {
        var result: [Range<String.Index>] = []
        var start = wrappedValue.startIndex
        while let range = wrappedValue.range(of: string, options: options, range: start..<wrappedValue.endIndex) {
            result.append(range)
            start = range.lowerBound < range.upperBound ? range.upperBound : wrappedValue.index(range.lowerBound, offsetBy: 1, limitedBy: wrappedValue.endIndex) ?? wrappedValue.endIndex
        }
        return result
    }
}
