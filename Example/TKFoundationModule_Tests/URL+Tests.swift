//
//  URL+Tests.swift
//  TKFoundationModule_Tests
//
//  Created by 聂子 on 2019/3/3.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import XCTest

class URLTests: XCTestCase {

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
}
