//
//  CGPoint+Exts.swift
//  TKFoundationModule
//
//  Created by 🐶 on 12/16/21.
//

import Foundation


extension CGPoint {
    public static func + (ls: CGPoint, rs: CGPoint) -> CGPoint {
        return CGPoint.init(x: ls.x + rs.x, y: ls.y + rs.y)
    }
    public static func - (ls: CGPoint, rs: CGPoint) -> CGPoint {
        return CGPoint.init(x: ls.x - rs.x, y: ls.y - rs.y)
    }
    public static func * (ls: CGPoint, rs: CGPoint) -> CGPoint {
        return CGPoint.init(x: ls.x * rs.x, y: ls.y * rs.y)
    }
    public static func / (ls: CGPoint, rs: CGPoint) -> CGPoint {
        return CGPoint.init(x: ls.x / rs.x, y: ls.y / rs.y)
    }
}


extension CGSize {
    public static func + (ls: CGSize, rs: CGSize) -> CGSize {
        return CGSize.init(x: ls.width + rs.width, y: ls.height + rs.height)
    }
    public static func - (ls: CGSize, rs: CGSize) -> CGSize {
        return CGSize.init(x: ls.width - rs.width, y: ls.height - rs.height)
    }
    public static func * (ls: CGSize, rs: CGSize) -> CGSize {
        return CGSize.init(x: ls.width * rs.width, y: ls.height * rs.height)
    }
    public static func / (ls: CGSize, rs: CGSize) -> CGSize {
        return CGSize.init(x: ls.width / rs.width, y: ls.height  rs.height)
    }
}
