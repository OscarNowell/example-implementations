//
//  ApiClient.swift
//  example-implementations
//
//  Created by Oscar Nowell on 16/10/2025.
//

import Foundation

// enum for laying out the expected basic error types
enum NetworkError: Error, Equatable {
    case urlError
    case decodingError
    case serverError(statusCode: Int)
}

// protocol for making it easy to mock the network client for testing
protocol NetworkClient {
    func fetch(from url: URL) async throws -> (Data, URLResponse)
}

class ApiClient {
    
    private let networkClient: NetworkClient
    
    let baseUrl: String = "https://api.github.com/"
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    // handles fetch user call and returning either a User object or throwing an error
    func fetchUser(with userId: String) async throws -> User {
        
        // guard check to create a url from the base url and the passed in userId
        guard let url = URL(string: "\(baseUrl)user/\(userId)") else {
            throw NetworkError.urlError
        }
        
        // await async call to the network client to fetch data and response from the given url
        let (data, response) = try await networkClient.fetch(from: url)
        
        // guards against statusCodes that would indicate an error has been returned. In this case anything outside of 200 - 299
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw NetworkError.serverError(statusCode: statusCode)
        }
        
        // try to decode and return the fetched JSON in a User object, throwing the appropriate error if failed
        do {
            return try JSONDecoder().decode(User.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}

struct User: Equatable, Codable {
    let id: String
    let name: String
    let email: String
}
