//
//  FileManage+Ext.swift
//  Pods-TKBaseModule_Example
//
//  Created by 聂子 on 2018/12/24.
//

import Foundation

extension FileManager {
    public enum PathType {
        case none
        case file
        case dic
    }
}

extension TypeWrapperProtocol where WrappedType == FileManager {

    var document: URL? {
        get {
            let manager = FileManager.default
            let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
            if urlForDocument.count > 0 {
                return urlForDocument[0] as URL
            }
            return nil
        }
    }

    /// 浅遍历(返回文件名，子目录名，符号链接等列表)
    ///
    /// - Parameter url: 路径
    /// - Returns: [String]
    public static func export(url: URL) -> Array<Any>? {
        let manager = FileManager.default
        return try? manager.contentsOfDirectory(atPath: url.path)
    }


    /// 浅遍历(返回文件名，子目录名，符号链接(路径)等列表)
    ///
    /// - Parameter url: 路径
    /// - Returns:
    public static func exportPath(url: URL) -> Array<Any>? {
        let manager = FileManager.default
        return try? manager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
    }


    /// 递归遍历
    ///
    /// - Parameters:
    ///   - url: 路径
    ///   - path: 是否输入path
    /// - Returns: 结果
    public static func exportAll(url: URL, is path: Bool = false ) -> FileManager.DirectoryEnumerator? {
        let manager = FileManager.default
        if path  {
            return  manager.enumerator(atPath: url.path)
        }else {
            return manager.enumerator(at: url, includingPropertiesForKeys: nil,options: .skipsHiddenFiles, errorHandler:nil)
        }
    }


    /// 判断文件/文件夹是否存在
    ///
    /// - Parameter path: 文件路径
    /// - Returns: 结果  false 不存在； true 存在
    public static func isExit( path: String) -> Bool {
        let manager = FileManager.default
       return manager.fileExists(atPath: path)
    }


    /// 判断路径是文件还是文件夹
    ///
    /// - Parameter path: 路径
    /// - Returns: 结果  .none 路径不存在
    public static func isDic(path : String) -> FileManager.PathType {
        let manager = FileManager.default
        if !FileManager.ns.isExit(path: path) {
            return .none
        }
        var isDir : ObjCBool = false
        manager.fileExists(atPath: path, isDirectory: &isDir)
        if isDir.boolValue {
            return .dic
        }
        return .file
    }



    /// 创建文件夹
    ///
    /// - Parameters:
    ///   - name: 文件名
    ///   - baseUrl: 基础路径
    /// - Returns: 是否成功  false 失败； true 成功
    public static func createFolder(name: String, baseUrl: URL) -> Bool {
        let manager = FileManager.default
        let folder = baseUrl.appendingPathComponent(name, isDirectory: true)
        let exist = FileManager.ns.isExit(path: folder.path)
        if !exist {
            do {
                try manager.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
                return true
            }catch let error {
                debugPrint(error)
                return false
            }
        }
        debugPrint("=========The folder already exists")
        return false
    }


    /// 创建文件夹
    ///
    /// - Parameters:
    ///   - directory: 基础路径
    ///   - path: 文件路径
    /// - Returns: 返回结果  false 失败； true 成功
    public static func createFolder (for directory:FileManager.SearchPathDirectory, path: String) -> Bool {
        let manager = FileManager.default
        let urls = manager.urls(for: directory, in: .userDomainMask)
        if urls.count <= 0 {
            debugPrint("========directory is not found or not process")
            return false
        }
        let url = urls[0] as URL
        let dir = url.path + path

        let exist = FileManager.ns.isExit(path: dir)
        if exist {
            debugPrint("The folder already exists")
            return false
        }

        do {
            try manager.createDirectory(atPath: dir, withIntermediateDirectories: true , attributes: nil)
            return true
        } catch let error {
            debugPrint(error)
            return false
        }
    }



    /// 创建文件
    ///
    /// - Parameters:
    ///   - name: 文件名
    ///   - fileBaseUrl: 文件路径
    /// - Returns: 文件结果  false 失败； true 成功
    public static func createFile(name: String, fileBaseUrl: URL) -> Bool {
        let manager = FileManager.default
        let file = fileBaseUrl.appendingPathComponent(name)
        let exit = manager.fileExists(atPath: file.path)
        if exit {
            debugPrint("The file already exists")
            return false
        }
       return manager.createFile(atPath: file.path, contents: nil , attributes: nil )
    }



    /// 创建文件
    ///
    /// - Parameters:
    ///   - directory: 基础路径
    ///   - path: 文件路径
    /// - Returns: 创建结果  false 失败； true 成功
    public static func createFile(for directory:FileManager.SearchPathDirectory, path: String) -> Bool {
        let manager = FileManager.default

        let urls = manager.urls(for: directory, in: .userDomainMask)
        if urls.count <= 0 {
            debugPrint("========directory is not found or not process")
            return false
        }
        let url = urls[0] as URL
        let dir = url.path + path

        let exist = FileManager.ns.isExit(path: dir)
        if exist {
            debugPrint("The file already exists")
            return false
        }

        return manager.createFile(atPath: dir, contents: nil , attributes: nil )
    }


    /// 复制文件
    ///
    /// - Parameters:
    ///   - path: 起始路径
    ///   - path: 结束路径
    /// - Returns: 复制结果  false 失败； true 成功
    public static func copy(from path:String, to targetPath: String) -> Bool {
        let manager = FileManager.default
        if !FileManager.ns.isExit(path: path) {
            debugPrint("path is not exist")
            return false
        }

        do {
            try manager.copyItem(atPath: path, toPath: targetPath)
            return true
        } catch let error {
            debugPrint(error)
        }
        return false
    }


    /// 移动文件
    ///
    /// - Parameters:
    ///   - path: 起始路径
    ///   - new: 目标路径
    /// - Returns: 结果  false 失败； true 成功
    public static func move(from path:String, to targetPath: String) -> Bool {
        let manager = FileManager.default
        if !FileManager.ns.isExit(path: path) {
            debugPrint("path is not exist")
            return false
        }
        do {
            try manager.moveItem(atPath: path, toPath: targetPath)
        } catch let error  {
            debugPrint(error)
        }

        return false
    }


    /// 删除文件或文件夹
    ///
    /// - Parameter path: 路径
    /// - Returns: 结果 false 失败； true 成功
    public static func remove(from path:String) -> Bool {
        let manager = FileManager.default
        do {
            try manager.removeItem(atPath: path)
        } catch let error  {
            debugPrint(error)
        }
        return false
    }


    /// 删除路径下所有
    ///
    /// - Parameter path: 路径 目录
    /// - Returns: 结果  false 失败； true 成功
    public static func removeAll(from dicPath:String) -> Bool {
        if FileManager.ns.isDic(path: dicPath) != .dic {
            debugPrint(" path is not dic or not exist, dicPath need folder path")
            return false
        }
        let manager = FileManager.default
        do {
            try manager.removeItem(atPath: dicPath)
            try manager.createDirectory(atPath: dicPath, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            debugPrint(error)
        }
        return false
    }


    /// 追加内容
    ///
    /// - Parameters:
    ///   - filePath: 文件路径
    ///   - content: 内容
    public static func writeToEnd(filePath: String, content: String) {
        if FileManager.ns.isDic(path: filePath) != .file  {
            debugPrint(" filePath is not file or not exist, filePath need file path")
            return
        }

        let appendedData = content.data(using: String.Encoding.utf8, allowLossyConversion: true) ?? Data()
        do {
            let writeHandler = try FileHandle(forWritingTo:URL(string: filePath)!)
            writeHandler.seekToEndOfFile()
            writeHandler.write(appendedData)
        } catch let error  {
            debugPrint(error)
        }
    }


    /// 获取路径对应文件或文件夹属性
    ///
    /// - Parameter path: 路径
    /// - Returns: 结果
    public static func pathAttribute(path: String) -> [FileAttributeKey : Any] {
        let manager = FileManager.default
        do {
           return try manager.attributesOfItem(atPath: path)
        } catch let error {
            debugPrint(error)
        }
        return [:]
    }


    /// 比较
    ///
    /// - Parameters:
    ///   - path1: 路径
    ///   - path2: 路径
    /// - Returns: 结果
    public static func equal(path1: String, path2: String) -> Bool{
        let manager = FileManager.default
        if !FileManager.ns.isExit(path: path1) {
            debugPrint("path1 is not exist")
            return false
        }
        if !FileManager.ns.isExit(path: path2) {
            debugPrint("path2 is not exist")
            return false
        }
       return manager.contentsEqual(atPath: path1, andPath: path2)
    }



    /// 计算文件夹大小
    ///
    /// - Parameter path: 路径
    /// - Returns: 大小 kb
    public static func size(path: String) -> Float {
       if !FileManager.ns.isExit(path: path) {
            debugPrint(" path is not exist")
            return 0.0
        }
        let manager = FileManager.default
        let type = FileManager.ns.isDic(path: path)
        switch type {
        case .none:
            debugPrint(" path is not exist")
            return 0.0
        case .file:
            do {
             let dic = try manager.attributesOfItem(atPath: path)
              return Float(dic[FileAttributeKey.size] as! Int)/(1024.0*1024.0)
            }catch {
                debugPrint("file attribute is nil, path is exist ???")
            }
            break
        case .dic:
            let childFilePath = manager.subpaths(atPath: path)
            var fileSize : Float = 0
            for p in childFilePath ?? [] {
                let fileAbsoluePath = path.appending("/").appending(p)
                let dic = try? manager.attributesOfItem(atPath: fileAbsoluePath)
                if dic == nil {
                    debugPrint("file attribute is nil, \(fileAbsoluePath) is exist ??? ")
                    break
                }
                fileSize += Float(dic![FileAttributeKey.size] as! Int)
            }
            return fileSize/(1024.0*1024.0)
        }

        return 0.0
    }
}



