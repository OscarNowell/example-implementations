//
//  Untitled.swift
//  example-implementations
//
//  Created by Oscar Nowell on 16/10/2025.
//

import Foundation
@testable import example_implementations

class MockNetworkClient: NetworkClient {
    
    // a fetch call count for the mock so testing can easily check if the fetch from network was called
    var fetchCallCount = 0
    
    var result: NetworkClientResponse?
    
    func fetch(from url: URL) async throws -> NetworkClientResponse {
        fetchCallCount += 1
        
        return result!
    }
}
