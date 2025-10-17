//
//  Untitled.swift
//  example-implementations
//
//  Created by Oscar Nowell on 16/10/2025.
//

import Foundation
@testable import example_implementations

class MockNetworkClient: NetworkClient {
    
    var result: NetworkClientResponse?
    
    func fetch(from url: URL) async throws -> NetworkClientResponse {
        return result!
    }
}
