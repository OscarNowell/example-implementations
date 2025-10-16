//
//  ApiClientTests.swift
//  example-implementationsTests
//
//  Created by Oscar Nowell on 16/10/2025.
//

import XCTest

@testable import example_implementations

final class ApiClientTests: XCTestCase {
    
    private var apiClient: ApiClient!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiClient = ApiClient()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // test base URL exists
    func test_apiClient_hasBaseUrl() throws {
        XCTAssertNotNil(apiClient.baseUrl)
    }
    
    // test base URL is valid String
    func test_apiClient_baseUrlIsValidString() throws {
        XCTAssertTrue(!apiClient.baseUrl.isEmpty)
    }
    
    // test fetchUser returns a response object with success and user
    func test_apiClient_fetchUser_returnsResponseObjectOfSuccessTypeWithUser() throws {
        let testUserId = "userId"
        let response = apiClient.fetchUser(with: testUserId, fail: false)
        
        if case .success(let user) = response {
            XCTAssertEqual(user.id, testUserId)
            return
        }
        
        XCTFail("expected response to be of type success")
    }
    
    func test_apiClient_fetchUser_returnsResponseObjectWithErrorWhenFailed() throws {
        let testUserId = "userId"
        let response = apiClient.fetchUser(with: testUserId, fail: true)
        
        if case .error(let message) = response {
            XCTAssertNotNil(message)
            return
        }
        
        XCTFail("expected response to be of type error")
    }
    
}
