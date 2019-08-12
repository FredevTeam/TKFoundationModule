//
//  Timer+Tests.swift
//  TKFoundationModule_Tests
//
//  Created by 聂子 on 2019/3/3.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import XCTest

class TimerTests: XCTestCase {

    private var timer: Timer = Timer.init()
    override func setUp() {
        timer = Timer.init()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_timer() {
        let exp = self.expectation(description: "timer")
        let time = Timer.ns.scheduledTimerWithTimerInterval(interval: 0.1, repeats: true) { (_) in
            print("xxxxxxx")
             exp.fulfill()
        }
        RunLoop.current.add(time, forMode: .default)
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}
