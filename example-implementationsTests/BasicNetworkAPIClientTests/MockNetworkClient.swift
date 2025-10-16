//
//  Untitled.swift
//  example-implementations
//
//  Created by Oscar Nowell on 16/10/2025.
//

import Foundation
@testable import example_implementations

class MockNetworkClient: NetworkClient {
    
    var dataToReturn: Data?
    var errorToThrow: Error?
    
    func fetch(from url: URL) async throws -> Data {
        if let error = errorToThrow {
            throw error
        }
        guard let data = dataToReturn else {
            throw NetworkError.decodingError
        }
        return data
    }
}
