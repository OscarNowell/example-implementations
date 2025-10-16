//
//  ApiClient.swift
//  example-implementations
//
//  Created by Oscar Nowell on 16/10/2025.
//

import Foundation

enum NetworkError: Error, Equatable {
    case urlError
    case decodingError
    case serverError(statusCode: Int)
}

protocol NetworkClient {
    func fetch(from url: URL) async throws -> (Data, URLResponse)
}

class ApiClient {
    
    private let networkClient: NetworkClient
    
    let baseUrl: String = "https://api.github.com/"
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func fetchUser(with userId: String) async throws -> User {
        
        guard let url = URL(string: "\(baseUrl)user/\(userId)") else {
            throw NetworkError.urlError
        }
        
        let (data, response) = try await networkClient.fetch(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw NetworkError.serverError(statusCode: statusCode)
        }
        
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
