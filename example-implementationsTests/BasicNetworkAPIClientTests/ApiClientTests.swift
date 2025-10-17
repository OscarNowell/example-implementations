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
    
    // test fetchUser returns valid success response with user
    func test_apiClient_fetchUser_response200ReturnsUser() async throws {
        
        let mockNetworkClient = MockNetworkClient()
        apiClient = ApiClient(networkClient: mockNetworkClient)
        
        let expectedUser = User(id: "1", name: "John Smith", email: "john.smith@email.com")
        
        let jsonData = try JSONEncoder().encode(expectedUser)
        
        let response200 = HTTPURLResponse(
            url: URL(string: "example_url")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        mockNetworkClient.result = NetworkClientResponse(data: jsonData, urlResponse: response200)
        
        let actualUser = try await apiClient.fetchUser(with: "1")
        
        XCTAssertEqual(actualUser, expectedUser)
    }
    
    // test fetchUser fails successfully with 404 error
    func test_apiClient_fetchUser_response404ThrowsError() async {
        
        let mockNetworkClient = MockNetworkClient()
        apiClient = ApiClient(networkClient: mockNetworkClient)

        let response404 = HTTPURLResponse(
            url: URL(string: "example_url")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )!
        
        mockNetworkClient.result = NetworkClientResponse(data: Data(), urlResponse: response404)

        do {
            _ = try await apiClient.fetchUser(with: "1")
            XCTFail("Expected fetch user to throw an error, but it succeeded")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .serverError(statusCode: 404))
        } catch {
            XCTFail("An unexpected error type was thrown: \(error)")
        }
    }
    
    func test_apiClient_fetchUser_onSuccessCachesUser() async throws {
        let mockNetworkClient = MockNetworkClient()
        apiClient = ApiClient(networkClient: mockNetworkClient)
        
        let expectedUser = User(id: "1", name: "John Smith", email: "john.smith@email.com")
        
        let jsonData = try JSONEncoder().encode(expectedUser)
        
        let response200 = HTTPURLResponse(
            url: URL(string: "example_url")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        mockNetworkClient.result = NetworkClientResponse(data: jsonData, urlResponse: response200)
        
        try await apiClient.fetchUser(with: "1")
        
        XCTAssertTrue(apiClient.cachedUsers.contains(expectedUser))
    }
    
    func test_apiClient_fetchUser_returnsCachedUserIfAvailable() async throws {
        let mockNetworkClient = MockNetworkClient()
        apiClient = ApiClient(networkClient: mockNetworkClient)
        
        let expectedUser = User(id: "1", name: "John Smith", email: "john.smith@email.com", cachedTime: Date())
        
        apiClient.cachedUsers.append(expectedUser)
        
        let jsonData = try JSONEncoder().encode(expectedUser)
        
        let response200 = HTTPURLResponse(
            url: URL(string: "example_url")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        mockNetworkClient.result = NetworkClientResponse(data: jsonData, urlResponse: response200)
        
        let actualUser = try await apiClient.fetchUser(with: "1")
        
        XCTAssertEqual(actualUser.cachedTime, expectedUser.cachedTime)
    }
}
