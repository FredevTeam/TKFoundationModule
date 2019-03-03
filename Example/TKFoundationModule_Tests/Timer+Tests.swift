//
//  Timer+Tests.swift
//  TKFoundationModule_Tests
//
//  Created by 聂子 on 2019/3/3.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import XCTest

class Timer_Tests: XCTestCase {

    private var timer: Timer = Timer.init()
    override func setUp() {
        timer = Timer.init()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_timer()  {
        let exp = self.expectation(description: "timer")
//        @discardableResult
      let time = timer.ns.scheduledTimerWithTimerInterval(interval: 0.1, repoats: true) { (timer) in
            print("xxxxxxx")
             exp.fulfill()
        }
//        timer  = Timer.ns.scheduledTimerWithTimerInterval(interval: 0.1, repoats: true) { (timer ) in
//            print("xxxxxxx")
//            exp.fulfill()
//        }
        RunLoop.current.add(time, forMode: .default)
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
