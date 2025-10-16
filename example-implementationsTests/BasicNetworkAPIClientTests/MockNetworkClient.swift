//
//  Untitled.swift
//  example-implementations
//
//  Created by Oscar Nowell on 16/10/2025.
//

import Foundation
@testable import example_implementations

class MockNetworkClient: NetworkClient {
    
    var result: Result<(Data, URLResponse), Error>!
    
    func fetch(from url: URL) async throws -> (Data, URLResponse) {
        return try result.get()
    }
}
