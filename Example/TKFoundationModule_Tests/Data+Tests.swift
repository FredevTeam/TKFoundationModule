//
//  Data+Tests.swift
//  TKFoundationModule_Tests
//
//  Created by 聂子 on 2019/1/31.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import XCTest
import TKFoundationModule

class DataTests: XCTestCase {

    fileprivate var data: Data?

    /// 开始之前调用
    override func setUp() {
        super.setUp()
        let string = "{\"status\":200,\"message\":\"xxxxxx\",\"data\":{\"message\":\"xxxx\",\"code\":201}}"
        data = string.data(using: .utf8)
    }

    func test_dataJson() {
        XCTAssertNotNil(data?.ns.json())
    }

    // 结束调用
    override func tearDown() {
        super.tearDown()
    }

    func testJson () {
        debugPrint("\(String(describing: data?.ns.json()))")
    }

}
