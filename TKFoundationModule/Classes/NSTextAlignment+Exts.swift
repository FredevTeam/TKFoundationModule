//
//  NSTextAlignment+Exts.swift
//  TKFoundationModule
//
//  Created by 🐶 on 12/16/21.
//

import Foundation
import CoreGraphics
#if os(macOS)
import AppKit
#endif

#if os(iOS)
import UIKit
#endif

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
