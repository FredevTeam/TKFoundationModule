//
//  FunctionProtocol.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/5/12.
//

import Foundation

public protocol FunctionProtocol {
    associatedtype TargetType

    /// 绝对值
    ///
    /// - Returns: fabs
    func abs() -> TargetType


    /// max int number
    ///
    /// - Returns: floorf()
    func floor() -> TargetType


    /// min int number
    ///
    /// - Returns: ceil()
    func ceil() -> TargetType



    /// 四舍五入
    ///
    /// - Returns: roundf()
    func round() -> TargetType
}


extension Float: FunctionProtocol {
    public func round() -> Float {
        return roundf(self)
    }

    public func abs() -> Float {
        return fabsf(self)
    }

    public func floor() -> Float {
        return floorf(self)
    }

    public func ceil() -> Float {
        return ceilf(self)
    }

    public typealias TargetType = Float
}

extension Double : FunctionProtocol {
    public func round() -> Double {
        return Darwin.round(self)
    }

    public func abs() -> Double {
        return fabs(self)
    }

    public func floor() -> Double {
        return Darwin.floor(self)
    }

    public func ceil() -> Double {
        return Darwin.ceil(self)
    }

    public typealias TargetType = Double
}
