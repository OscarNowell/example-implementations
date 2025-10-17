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
// custom response object returned instead of default tuple for readability
protocol NetworkClient {
    func fetch(from url: URL) async throws -> NetworkClientResponse
}

// response object for passing back result from URLSession
struct NetworkClientResponse {
    let data: Data
    let urlResponse: URLResponse
}

// user struct for decoding returned JSON into
struct User: Equatable, Codable {
    let id: String
    let name: String
    let email: String
    var cachedTime: Date?
    
    func isCacheValid(invalidateAfter: Double) -> Bool {
        guard let validCachedTime = cachedTime else {
            return false
        }
        
        return validCachedTime > (Date() - invalidateAfter)
    }
}

class ApiClient {
    
    private let networkClient: NetworkClient
    
    private let invalidateCacheAfter: Double = 60
    let baseUrl: String = "https://api.github.com/"
    let acceptableStatusCodeRange: ClosedRange = 200...299
    
    // this could be a Set to automatically have unique values?
    var cachedUsers: [User] = []
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func forceRefresh() {
        cachedUsers.removeAll()
    }
    
    // handles fetch user call and returning either a User object or throwing an error
    func fetchUser(with userId: String) async throws -> User {
        
        // guard check to create a url from the base url and the passed in userId
        guard let url = URL(string: "\(baseUrl)user/\(userId)") else {
            throw NetworkError.urlError
        }
        
        // if we have a cached user matching the passed in id
        if let cachedUser = cachedUsers.first(where: { $0.id == userId }) {
            // if the cached users cachedTime is valid
            if cachedUser.isCacheValid(invalidateAfter: invalidateCacheAfter) {
                return cachedUser
            } else {
                // otherwise remove the cached user becacuse it's become invalid
                cachedUsers.removeAll(where: { $0.id == userId })
            }
        }

        var user = try await fetch(from: url) as User
        
        user.cachedTime = Date()
        
        cachedUsers.append(user)
        
        return user
    }
    
    // a generic fetch function that returns type T
    private func fetch<T: Decodable>(from url: URL) async throws -> T {
        
        // await the result of the fetch call to the network client
        let networkClientResponse = try await networkClient.fetch(from: url)
        
        // guard against an invalid response from the network client
        guard let httpResponse = networkClientResponse.urlResponse as? HTTPURLResponse else {
            // if response isn't a valid HTTPURLResponse then we have no statusCode, so throw effort with default code of 0
            throw NetworkError.serverError(statusCode: 0)
        }
        
        // check the returned statusCode is within the acceptable range
        if !acceptableStatusCodeRange.contains(httpResponse.statusCode) {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        // try to decode and return the fetched JSON in a User object, throwing the appropriate error if failed
        do {
            return try JSONDecoder().decode(T.self, from: networkClientResponse.data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
