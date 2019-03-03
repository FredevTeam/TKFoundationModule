//
//  URL+Tests.swift
//  TKFoundationModule_Tests
//
//  Created by 聂子 on 2019/3/3.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import XCTest

class URL_Tests: XCTestCase {

    private var url: URL!
    override func setUp() {
        url = "https://www.baidu.com"
    }

    override func tearDown() {
        
    }
    
    func test_queryDic() {
//        url = "https://www.baidu.com/name/taokan"
        url = "https://www.baidu.com/there?name=ferret"
        print("\(url.ns.queryDictionary ?? [:])")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
