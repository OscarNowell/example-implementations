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
    func fetch(from url: URL) async -> Result<Data, NetworkError>
}

class ApiClient {
    
    private let networkClient: NetworkClient
    
    let baseUrl: String = "https://api.github.com/"
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func fetchUser(with userId: String) async -> Result<User, NetworkError> {
        
        guard let url = URL(string: "\(baseUrl)user/\(userId)") else {
            return .failure(.urlError)
        }
        
        let result = await networkClient.fetch(from: url)
        
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let data):
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                return .success(user)
            } catch {
                return .failure(.decodingError)
            }
        }
    }
}

struct User: Equatable, Codable {
    let id: String
    let name: String
    let email: String
}
