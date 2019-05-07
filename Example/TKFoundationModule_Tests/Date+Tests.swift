//
//  Date+Tests.swift
//  TKFoundationModule_Tests
//
//  Created by 聂子 on 2019/1/31.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import XCTest
import TKFoundationModule

class DateTests: XCTestCase {

    private var dateFormatter: DateFormatter!

    override func setUp() {
        super.setUp()
        dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }

    func test_isYear() {
        dateFormatter.dateFormat = "YYYY/mm/DD"
        let date  = dateFormatter.date(from: "2019/03/20")
        XCTAssertTrue(date?.ns.isYear() ?? false)
    }

    func test_tomorrow() {
        // 时区问题 所有多一天
        let date  = dateFormatter.date(from: "2019-04-30")
        XCTAssertTrue(date?.ns.isTomorrow() ?? false)
    }

    func test_yesterday() {
        let date = dateFormatter.date(from: "2019-04-27")
        XCTAssertTrue(date?.ns.isYesterday() ?? false)
    }

    func test_today() {
        let date = Date.init()
        XCTAssertTrue(date.ns.isToday())
    }

    func test_week() {
        let date = dateFormatter.date(from: "2019-04-25")
        XCTAssertTrue(date?.ns.isWeek() ?? false )
    }

    func test_month() {
        let date = dateFormatter.date(from: "2019-04-21")
        XCTAssertTrue(date?.ns.isMonth() ?? false )
    }

    func test_weekDay() {
        let date = dateFormatter.date(from: "2019-04-29")
        XCTAssertTrue(date?.ns.weekDay()  == 2)
    }

}
