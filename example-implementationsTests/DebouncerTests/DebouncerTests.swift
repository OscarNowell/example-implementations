//
//  DebouncerTests.swift
//  example-implementationsTests
//
//  Created by Oscar Nowell on 17/10/2025.
//

import XCTest

@testable import example_implementations

@MainActor
final class DebouncerTests: XCTestCase {
    
    var debouncer: Debouncer!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        debouncer = Debouncer(delay: .milliseconds(300))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // test that the debouncer returns false if under key stroke time limit
    
    func test_debouncer_callsAction_afterDelay() async throws {
        
        let expectation = XCTestExpectation(description: "Action was called")
        
        debouncer = Debouncer(delay: .milliseconds(100))
        
        var actionWasCalled = false
        
        debouncer.debounce {
            actionWasCalled = true
            expectation.fulfill()
        }
        
        XCTAssertFalse(actionWasCalled, "Action should not be called immediately")
        
        await fulfillment(of: [expectation], timeout: 0.2)
        
        XCTAssertTrue(actionWasCalled, "Action should have been called after delay")
    }
    
    
}
