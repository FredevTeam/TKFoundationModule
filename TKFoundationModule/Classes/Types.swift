//
//  Types.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/7/14.
//

import Foundation



#if os(macOS)

import AppKit

public typealias View            = NSView
public typealias ViewController = NSViewController
public typealias Window            = NSWindow
public typealias Control        = NSControl
public typealias TextView        = NSTextView
public typealias TextField        = NSTextField
public typealias Button            = NSButton
public typealias Font            = NSFont
public typealias Color            = NSColor
public typealias StackView        = NSStackView
public typealias Image            = NSImage
public typealias BezierPath        = NSBezierPath
public typealias ScrollView        = NSScrollView
public typealias Screen            = NSScreen
public typealias Application       = NSApplication
public typealias Responder         = NSResponder
#else

import UIKit
public typealias Responder      = UIResponder
public typealias Application    = UIApplication
public typealias View            = UIView
public typealias ViewController = UIViewController
public typealias Window            = UIWindow
public typealias Control        = UIControl
public typealias TextView        = UITextView
public typealias TextField        = UITextField
public typealias Button            = UIButton
public typealias Font            = UIFont
public typealias Color            = UIColor
@available(iOS 9.0, *)
public typealias StackView        = UIStackView
public typealias Image            = UIImage
public typealias BezierPath        = UIBezierPath
public typealias ScrollView        = UIScrollView
public typealias Screen            = UIScreen

#endif

