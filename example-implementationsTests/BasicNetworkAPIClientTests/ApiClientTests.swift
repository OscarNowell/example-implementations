//
//  ApiClientTests.swift
//  example-implementationsTests
//
//  Created by Oscar Nowell on 16/10/2025.
//

import XCTest

@testable import example_implementations

@MainActor
final class ApiClientTests: XCTestCase {
    
    private var apiClient: ApiClient!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mockNetworkClient = MockNetworkClient()
        apiClient = ApiClient(networkClient: mockNetworkClient)
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
    
    // test fetchUser returns valid response object with network call
    func test_apiClient_fetchUser_returnsValidResultObject() async throws {
        
        let mockNetworkClient = MockNetworkClient()
        apiClient = ApiClient(networkClient: mockNetworkClient)
        
        let expectedUser = User(id: "1", name: "Example Name", email: "exampleEmail@Email.com")
        let jsonData = try JSONEncoder().encode(expectedUser)
        
        mockNetworkClient.resultToReturn = .success(jsonData)
        
        let result = await apiClient.fetchUser(with: "1")
        
        if case .success(let returnedUser) = result {
            XCTAssertEqual(returnedUser, expectedUser)
        } else {
            XCTFail("Expected successful result. \(result)")
        }
    }
    
    // test fetchUser returns the correct error on fail
    func test_apiClient_fetchUser_returnsCorrectError() async {
        
        let mockNetworkClient = MockNetworkClient()
        apiClient = ApiClient(networkClient: mockNetworkClient)

        let expectedError = NetworkError.fetchError
        mockNetworkClient.resultToReturn = .failure(expectedError)
        
        let result = await apiClient.fetchUser(with: "1")
        
        if case .failure(let returnedError) = result {
            XCTAssertEqual(returnedError, expectedError)
        } else {
            XCTFail("Expected failure result. \(result)")
        }
    }
}
