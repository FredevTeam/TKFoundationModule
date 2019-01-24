//
//  Int+Ext.swift
//  Pods-TKBaseModule_Example
//
//  Created by 聂子 on 2018/12/24.
//

import Foundation
//
extension Int : NamespaceWrappable{}
extension TypeWrapperProtocol where WrappedType == Int {
    /// 随机数
    ///
    /// - Parameter max: 最大数
    /// - Returns: 1 ~ max 的随机数
    func random(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max))) + 1
    }

    /// 随机数
    ///
    /// - Parameter length: 长度
    /// - Returns: 数
    func random (length: Int) -> Int {
        return 0
    }


    /// 随机数
    ///
    /// - Returns: 任意随机数
    func random () -> Int {
        return Int(arc4random())
    }
    
    /*这是一个内置函数
     lower : 内置为 0，可根据自己要获取的随机数进行修改。
     upper : 内置为 UInt32.max 的最大值，这里防止转化越界，造成的崩溃。
     返回的结果： [lower,upper) 之间的半开半闭区间的数。
     */
    
    /// 随机数
    ///
    /// - Parameters:
    ///   - lower: 最小
    ///   - upper: 最大
    /// - Returns: 结果
    public static func random(lower: Int = 0,upper: Int = Int(UInt32.max)) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower)))
    }

    /// 生成某个区间的随机数
    ///
    /// - Parameter range: 区间
    /// - Returns: 结果
    public static func random(range: Range<Int>) -> Int {
        return random(lower: range.lowerBound, upper: range.upperBound)
    }
    
    /// 生成某个区间的随机数
    ///
    /// - Parameters:
    ///   - from: 最小值
    ///   - to: 最大区间
    /// - Returns: 随机值
//    public static func random(from:Int, to:Int)-> Int {
//        return Int(from + Int(arc4random() % (to - from + 1)))
//    }
    
    
}
