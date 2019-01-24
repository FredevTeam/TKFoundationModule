//
//  Print+ext.swift
//  Pods-TKBaseModule_Example
//
//  Created by 聂子 on 2018/11/11.
//

import Foundation


/// 重载 print
///
/// - Parameters:
///   - item: 信息content
///   - dsohandle: 地址
///   - columnNumber: 行号
///   - fileName: 文件名
///   - methodName: 方法名
///   - lineNumber: 行数
public func print(message item:Any?,dsohandle:UnsafeRawPointer = #dsohandle, columnNumber: Int = #column, fileName: String = #file, methodName: String = #function, lineNumber:Int = #line){
    tk_print(item, debug: false)
}
/// 重载 debugPrint
///
/// - Parameters:
///   - item: 信息content
///   - dsohandle: 地址
///   - columnNumber: 行号
///   - fileName: 文件名
///   - methodName: 方法名
///   - lineNumber: 行数
public func debugPrint(message item:Any?,dsohandle:UnsafeRawPointer = #dsohandle, columnNumber: Int = #column, fileName: String = #file, methodName: String = #function, lineNumber:Int = #line){
    tk_print(item, debug: true)
}

/// 自定义实现 print
///
/// - Parameters:
///   - item: 信息content
///   - dsohandle: 地址
///   - columnNumber: 行号
///   - fileName: 文件名
///   - methodName: 方法名
///   - lineNumber: 行数
func tk_print(_ message:Any?,dsohandle:UnsafeRawPointer = #dsohandle, columnNumber: Int = #column, fileName: String = #file, methodName: String = #function, lineNumber:Int = #line, debug: Bool = true) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let title = "文件名:\(fileName)\n方法:\(methodName)\n行号:\(lineNumber)\n时间:" + dateFormatter.string(from: Date()) + "\n地址:" + "\(dsohandle)" + "\n"
    if debug {
        debugPrint("==========================Debug===========================")
        debugPrint(title + "日志:" + ((message as? String) ?? ""))
        debugPrint("==========================Debug===========================")
    }else {
        print("=====================================================")
        print(title +  "日志:" +  ((message as? String) ?? ""))
        print("=====================================================")
    }
}

//    #if DEBUGSWIFT
//    debugPrint("==========================Debug===========================")
//    debugPrint(title + "日志:" + ((message as? String) ?? ""))
//    debugPrint("==========================Debug===========================")
//    #else
//    print("=====================================================")
//    print(title +  "日志:" +  ((message as? String) ?? ""))
//    print("=====================================================")
//    #endif
