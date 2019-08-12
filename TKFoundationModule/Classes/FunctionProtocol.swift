//
//  FunctionProtocol.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/5/12.
//

import Foundation

protocol FunctionProtocol {
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
    func round() -> Float {
        return roundf(self)
    }

    func abs() -> Float {
        return fabsf(self)
    }

    func floor() -> Float {
        return floorf(self)
    }

    func ceil() -> Float {
        return ceilf(self)
    }

    typealias TargetType = Float
}

extension Double : FunctionProtocol {
    func round() -> Double {
        return Darwin.round(self)
    }

    func abs() -> Double {
        return fabs(self)
    }

    func floor() -> Double {
        return Darwin.floor(self)
    }

    func ceil() -> Double {
        return Darwin.ceil(self)
    }

    typealias TargetType = Double
}
