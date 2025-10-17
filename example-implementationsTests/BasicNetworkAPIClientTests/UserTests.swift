//
//  UserTests.swift
//  example-implementationsTests
//
//  Created by Oscar Nowell on 17/10/2025.
//

import XCTest

@testable import example_implementations

final class UserTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func test_user_isCachedInvalid_returnsTrueIfInvalid() throws {
        let userToTest = User(id: "1", name: "Test", email: "testemail", cachedTime: Date() - 60)
        
        XCTAssertTrue(userToTest.isCacheInvalid(invalidateAfter: 40))
    }
    
    func test_user_isCacheInvalid_returnsFalseIfValid() throws {
        let userToTest = User(id: "1", name: "Test", email: "testemail", cachedTime: Date() - 60)

        XCTAssertFalse(userToTest.isCacheInvalid(invalidateAfter: 61))
    }
}
