//
//  Tree.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/12/30.
//

import Foundation


public class Node<T> {
    private(set) public  var nodeId: String = UUID.init().uuidString
    
    private(set) public weak var parentNode: Node?
    private(set) public var childrens: [Node] = []
    
    private(set) public var value: T
    
    public init(value: T) {
        self.value = value
    }
}

extension Node {
    public convenience init(value: T, parentNode: Node?) {
        self.init(value: value)
        self.parentNode = parentNode
    }
}

// MARK: - children node insert
extension Node {
    public func add(children node: Node) {
        self.childrens.append(node)
        node.parentNode = self
    }
    public func insert(children node: Node)  {
        self.childrens.append(node)
        node.parentNode = self
    }
    public func insert(children node: Node, index: Int)  {
        self.childrens.insert(node, at: index)
        node.parentNode = self
    }
    public func insert(children nodes:[Node], index: Int) {
        self.childrens.insert(contentsOf: nodes, at: index)
        nodes.forEach{$0.parentNode = self}
    }
}


extension Node {
    public func remove(children node: Node) -> Bool {
        if let index = self.childrens.firstIndex(where: {node.nodeId == $0.nodeId}) {
            self.childrens.remove(at: index)
            return true
        }
        debugPrint("is not found")
        return false
    }
   public func remove(from nodeId: String) -> Bool {
        if let index = self.childrens.firstIndex(where: {nodeId == $0.nodeId}) {
            self.childrens.remove(at: index)
            return true
        }
        debugPrint("is not found")
        return false
    }
}


// MARK: - search
extension Node {
    public func search(from nodeId: String) -> Node? {
        if nodeId == self.nodeId {
            return self
        }
        for child  in childrens {
            if let found = child.search(from: nodeId) {
                return found
            }
        }
        return nil
    }
}

extension Node where T: Equatable {
    // 1
   public func search(value: T) -> Node? {
        // 2
        if value == self.value {
            return self
        }
        // 3
        for child in childrens {
            if let found = child.search(value: value) {
                return found
            }
        }
        // 4
        return nil
    }
}


extension Node: CustomStringConvertible, CustomDebugStringConvertible {
    public var debugDescription: String {
        return description
    }
    
    // 2
    public var description: String {
        // 3
        var text = "\(value)"
        
        // 4
        if !childrens.isEmpty {
            text += " {" + childrens.map { $0.description }.joined(separator: ", ") + "} "
        }
        return text
    }
}
