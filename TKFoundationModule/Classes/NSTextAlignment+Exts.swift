//
//  NSTextAlignment+Exts.swift
//  TKFoundationModule
//
//  Created by 🐶 on 12/16/21.
//

import Foundation
import CoreGraphics


extension TypeWrapperProtocol where WrappedType == NSTextAlignment {
    
    public var alignmentMode: CATextLayerAlignmentMode {
        switch self.wrappedValue {
        case .left:
            return .left
        case .right:
            return .right
        case .center:
            return .center
        case .justified:
            return .justified
        case .natural:
            return .natural
        @unknown default:
                return .init(rawValue: "\(self.wrappedValue.rawValue)")
        }
    }
}
