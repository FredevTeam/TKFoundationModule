//
//  Array+Tests.swift
//  TKFoundationModule_Tests
//
//  Created by 聂子 on 2019/3/2.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import XCTest
import TKFoundationModule

class ArrayTests: XCTestCase {

    private var array: [String] = []
    private var numberArray: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    override func setUp() {
        array.append("1. xxx")
        array.append("2. wwww")
        array.append("3. qqqq")
        array.append("4. ooooo")
    }

    // 未通过
    func test_subscript1() {
        XCTAssertTrue(numberArray[safe : 2] == 2)
    }

    func test_subscript2() {

        XCTAssertTrue([][safe: 2] == nil)
    }

    func test_random() {
        for _  in 0...5 {
            print("\(String(describing: array.ns.random))")
        }
    }

    func test_random2() {
        XCTAssertTrue([].ns.random == nil)
    }

    func test_subArray() {
//        print("\(array.ns.subArray(to: 2)?.count)")
        XCTAssert(array.ns.subArray(to: 2)?.count == 3)
    }

    func test_bubArrayTo() {
//        print("\(array.ns.subArray(from: 1, to: 3)?.count)")
        XCTAssert(array.ns.subArray(from: 1, to: 3)?.count == 3)
    }

    func test_subscript() {
        print("\(String(describing: array.ns[safe:1]))")
    }

    func test_shuffle() {
        print("\(array.ns.shuffle())")
    }

    func test_find() {
        XCTAssert(array.ns.find(fn: { (string) -> Bool in
            string == "4. ooooo"
        }).count > 0)
    }

    func test_nextOf() {
        XCTAssert(array.ns.nextOf("4. ooooo", first: false) == nil)
        XCTAssert(array.ns.nextOf("4. ooooo") == nil)
        XCTAssert(array.ns.nextOf("3. qqqq") == "4. ooooo")
        XCTAssert(array.ns.nextOf("4. ooooo", first: true) == "1. xxx")
    }

    func test_contains() {
        XCTAssertTrue(numberArray.ns.contains(items: 1, 2))
        XCTAssertFalse(numberArray.ns.contains(items: 20, 1))
    }

    func test_find2() {
        XCTAssertTrue(numberArray.ns.find(item: 3) == 3)
        XCTAssertFalse(numberArray.ns.find(item: 20) == 2)
    }

    func test_index() {
        XCTAssertFalse((numberArray.ns.index(of: { (index) -> Bool in
            index == 200
        }) != nil))
        XCTAssertTrue(numberArray.ns.index(of: { (index) -> Bool in
            index == 0
        }) == 0)
    }

    func test_each() {
        numberArray.ns.each { (index, item) in
            print("index:\(index) , item:\(item)")
        }
    }

    func test_check() {
        XCTAssertFalse(numberArray.ns.check(condition: { (index) -> Bool in
            index > 200
        }))
        XCTAssertTrue(numberArray.ns.check(condition: { (index) -> Bool in
            index >= 0
        }))
    }

    func test_count() {
        XCTAssertTrue(numberArray.ns.count(condition: { (index) -> Bool in
            index <= 1
        }) == 2)
    }

    func test_dictionary () {
        print(array.ns.dictionary { (string) -> (key: String, value: String)? in
            return (key: "1", value : string)
        })
        print(numberArray.ns.dictionary(transform: { (index) -> (key: String, value: Int)? in
            if index > 5 {
                return (key: "1", value: index)
            }
            return (key: "2", value: index)
        }))
    }

    func test_sync() {
        print(numberArray.ns.sync({ (index) -> Bool in
            index > 0
        }))
    }

}
