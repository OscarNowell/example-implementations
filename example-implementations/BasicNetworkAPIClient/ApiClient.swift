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
    case fetchError
}

protocol NetworkClient {
    func fetch(from url: URL) async throws -> Data
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
        
        let data = try await networkClient.fetch(from: url)
        
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            throw NetworkError.decodingError
        }
    }
}

struct User: Equatable, Codable {
    let id: String
}
