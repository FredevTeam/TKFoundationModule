//
//  Dictionary+Tests.swift
//  TKFoundationModule_Tests
//
//  Created by 聂子 on 2019/1/31.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import XCTest
import TKFoundationModule

class Dictionary_Tests: XCTestCase {
    
    fileprivate var dic: Dictionary<String, String> = [:]
    override func setUp() {
        super.setUp()
        dic.updateValue("name", forKey: "1")
        dic.updateValue("16", forKey: "age")
    }
    
    func test_subscript() {
        XCTAssertNil(dic[safe: "2"])
        XCTAssertTrue(dic[safe: "1"] == "name")
    }
    
    func test_string(){
        XCTAssertEqual(dic.ns.string(key: "1", def: nil), "name")
        XCTAssertNil(dic.ns.string(key: "2", def: nil))
        XCTAssertEqual(dic.ns.string(key: "2", def: "age"), "age")
    }
    
    func test_int() {
        
    }
    
    func test_has() {
        XCTAssertTrue(dic.ns.has(key: "age"))
        XCTAssertFalse(dic.ns.has(key: "address"))
    }
    
    func test_toData() {
        let dic = ["1":"20","2":"30"]
        XCTAssertNotNil(dic.ns.data(options: nil))
    }
    
    func test_toString() {
        let dic = ["1":"20","2":"30"]
        XCTAssertNotNil(dic.ns.string(options: nil))
    }
    
    func test_add() {
        let dic = ["1":"20","2":"30"]
        let dic2 = ["3":"20","4":"30"]
        XCTAssertEqual((dic + dic2).keys.count, 4)
    }
    
    func test_remove() {
        let dic = ["1":"20","2":"30"]
        XCTAssertTrue(dic.ns.remove(for: ["1","2"]).keys.count == 0)
    }
    
    func test_array() {
        XCTAssertTrue(dic.ns.array().count == 2)
    }
    
    func test_keys() {
        let dic = ["1":"20","2":"20"]
        XCTAssertEqual(dic.ns.keys(for: "20"), ["1","2"])
    }
    
}
