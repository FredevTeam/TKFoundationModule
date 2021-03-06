//
//  Dcitionary+Ext.swift
//  TKBaseModule
//
//  Created by 聂子 on 2019/1/5.
//

import Foundation

public struct DictionaryProxy<Key:Hashable, Value>{
    let base : Dictionary<Key, Value>
    init(proxy: Dictionary<Key, Value>) {
        base = proxy
    }
}


///  MARK: - 下标扩展
extension Dictionary {

   /// 下标通过 key 获取value
   ///
   /// - Parameter key: key
    /// - Note:
    ///     本操作允许空值存在
   public subscript (safe key: Key) -> Value? {
        return self.keys.contains(key) ? self[key] : nil
    }
}

extension Dictionary: NamespaceWrappable{
    public var ns: DictionaryProxy<Key, Value> {
        return DictionaryProxy(proxy: self)
    }
    public static var ns: DictionaryProxy<Key, Value>.Type {
        return DictionaryProxy.self
    }
}


/// MARK: - 数据类型转换 带有默认值
extension DictionaryProxy {
    /// sting
    ///
    /// - Parameters:
    ///   - name: key
    ///   - def: default value
    /// - Returns: value
    public func string(key name:Key, def: String?) -> String? {
        return base[name] as? String ?? def
    }
    
    /// int
    ///
    /// - Parameters:
    ///   - name: key
    ///   - def: default value
    /// - Returns: value
    public func int(key name: Key, def:Int?) -> Int? {
        return base[name] as? Int ?? def
    }
    
    /// double
    ///
    /// - Parameters:
    ///   - name: key
    ///   - def: default value
    /// - Returns: value
    public func double(key name: Key, def:Double?) -> Double? {
        return base[name] as? Double ?? def
    }
    
    /// float
    ///
    /// - Parameters:
    ///   - name: key
    ///   - def: default value
    /// - Returns: value
    public func float(key name: Key, def:Float?) -> Float? {
        return base[name] as? Float ?? def
    }
    
    /// bool
    ///
    /// - Parameters:
    ///   - name: key
    ///   - def: default value
    /// - Returns: value
    public func bool(key name: Key, def:Bool?) -> Bool? {
        return base[name] as? Bool ?? def
    }
    
    /// bool
    ///
    /// - Parameters:
    ///   - name: key
    ///   - def: default value
    /// - Returns: value
    public func bool(key name: Key, def:Bool) -> Bool {
        return base[name] as? Bool ?? def
    }
    
    
    /// 是否存在
    ///
    /// - Parameter key: key
    /// - Returns: bool
    public func has(key name: Key) -> Bool {
        return base.index(forKey:name) != nil
    }
    
    
    /// dic  ----> json data
    ///
    /// - Parameter options: options
    /// - Returns: json data
    public func data(options: JSONSerialization.WritingOptions?) -> Data? {
        guard JSONSerialization.isValidJSONObject(base) else {
            return nil
        }
        
      return try?  JSONSerialization.data(withJSONObject: base, options: options ??  JSONSerialization.WritingOptions())
    }
    
    
    /// dic -------> json string
    ///
    /// - Parameter options: options
    /// - Returns: json string
    public func string(options: JSONSerialization.WritingOptions?) -> String? {
        guard JSONSerialization.isValidJSONObject(base) else {
            return nil
        }
        guard let data = try? JSONSerialization.data(withJSONObject: base, options: options ?? JSONSerialization.WritingOptions()) else {
            return nil
        }
        return String.init(data: data, encoding: .utf8)
    }
    
    
    /// 合并两个字典
    /// 此操作当key 相同h时 second 会覆盖 first 的
    /// - Parameters:
    ///   - first:
    ///   - second:
    /// - Returns:
    static public func + (first:DictionaryProxy, second: DictionaryProxy) -> [Key:Value] {
        var result = first.base
        second.base.forEach { (key , value ) in
            result.updateValue(value, forKey: key)
        }
        return result
    }
    
    
    /// 去除
    ///
    /// - Parameters:
    ///   - first: first description
    ///   - second: second description
    /// - Returns: return value description
    public static func - (first:DictionaryProxy, second: DictionaryProxy) -> [Key: Value] {
        var result = first.base
        second.base.forEach { (key , value) in
            result.removeValue(forKey: key)
        }
        return result
    }
    
    
    /// 删除value
    ///
    /// - Parameter keys: keys
    /// - Returns: new dic
    public func remove(for keys:[Key]) -> [Key:Value] {
        var result = base
        keys.forEach { (key ) in
            result.removeValue(forKey: key)
        }
        return result
    }
    
    
    /// dic ----> array
    ///
    /// - Returns: array
    public func array() -> [(key:Key, value:Value)] {
        var result:[(key:Key, value: Value)] = []
        base.forEach { (key, vlaue) in
            result.append((key: key, value: vlaue))
        }
        return result
    }


    /// 返回一个新字典，其中包含由给定的闭包转换的键以及该字典的值。
    ///
    /// - Parameter 转换键的闭包。每个转换的键都必须是唯一的。
    /// - Returns: A dictionary containing transformed keys and the values of this dictionary.
    func mapKeys<T>(transform: (Key) throws -> T) rethrows -> [T: Value] {

        let keysWithValues = try self.base.map { (key, value) -> (T, Value) in
            (try transform(key), value)
        }

        return [T: Value](uniqueKeysWithValues: keysWithValues)
    }

}

extension Dictionary where Key: Equatable {
    
    
    
    /// 根据key 删除 value
    ///
    /// - Parameter keys: value
    public mutating func remove(for keys:[Key]) {
        keys.forEach { (key) in
            removeValue(forKey: key)
        }
    }
    
    
    /// 合并两个字典
    ///
    /// - Parameters:
    ///   - first: first dic
    ///   - sencond: second dic
    /// - Returns: new dic
    static public func + (first: [Key: Value], second: [Key: Value]) -> [Key: Value] {
        var result = first
        second.forEach { (key, value ) in
            result.updateValue(value, forKey: key)
        }
        return result
    }
    
    
    /// 合并两个字典
    ///
    /// - Parameters:
    ///   - first: first dic
    ///   - second: second dic
    public static func += (first: inout [Key: Value], second: [Key: Value]) {
//        first.forEach{ second[$0] = $1}
        second.forEach { (key , value ) in
            first.updateValue(value, forKey: key)
        }
    }


    ///  enable + operator dictionary
    ///
    /// - Parameters:
    ///   - left: left dic
    ///   - right: right dic
    /// - Returns: merged dic
    static public func + <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>)
        -> Dictionary<K,V>
    {
        var map = Dictionary<K,V>()
        for (k, v) in left {
            map[k] = v
        }
        for (k, v) in right {
            map[k] = v
        }
        return map
    }

    /// 删除
    ///
    /// - Parameters:
    ///   - dic: dic
    ///   - keys: keys
    /// - Returns: new dic
    public static func - (dic: [Key: Value], keys: [Key]) -> [Key: Value] {
        var result = dic
        keys.forEach { (key) in
            result.removeValue(forKey: key)
        }
        return result
    }
    
    /// 删除
    ///
    /// - Parameters:
    ///   - dic: dic
    ///   - keys: keys
    public static func -= (dic: inout [Key: Value], keys: [Key]){
        keys.forEach { (key) in
            dic.removeValue(forKey: key)
        }
    }
//    / 与或非
    
}


extension DictionaryProxy where Value: Equatable {
    
    /// key  for value
    /// 根据value 查找 key
    /// - Parameter value: value
    /// - Returns: [key]
    public func keys(value v: Value) -> [Key] {
        return base.keys.filter({ (key) -> Bool in
            base[key] == v
        })
    }
}



extension Sequence {
    func sorted<T: Comparable>(by attribute: KeyPath<Element, T>) -> [Element] {
        return sorted(by: { $0[keyPath: attribute] < $1[keyPath: attribute] })
    }
}

