//
//  DebouncerTests.swift
//  example-implementationsTests
//
//  Created by Oscar Nowell on 17/10/2025.
//

import XCTest

@testable import example_implementations

final class DebouncerTests: XCTestCase {
    
    var debouncer: Debouncer!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        debouncer = Debouncer()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // test that the debouncer returns false if under key stroke time limit
    
    func test_debouncer_canMakeNetworkCall_returnsTrue() throws {
        XCTAssertTrue(debouncer.canMakeNetworkCall())
    }
}
