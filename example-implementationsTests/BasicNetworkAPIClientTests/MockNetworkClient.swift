//
//  Untitled.swift
//  example-implementations
//
//  Created by Oscar Nowell on 16/10/2025.
//

import Foundation
@testable import example_implementations

class MockNetworkClient: NetworkClient {
    
    var resultToReturn: Result<Data, NetworkError>?
    
    func fetch(from url: URL) async -> Result<Data, NetworkError> {
        guard let result = resultToReturn else {
            fatalError("MockNetworkClient result was not set")
        }
        return result
    }
}
