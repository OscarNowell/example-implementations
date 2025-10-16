//
//  ApiClient.swift
//  example-implementations
//
//  Created by Oscar Nowell on 16/10/2025.
//

import Foundation

class ApiClient {
    
    let baseUrl: String = "https://api.github.com/"
    
    func fetchUser(with userId: String) -> Response {
        return .success(user: User(id: userId))
    }
}

struct User {
    let id: String
}

enum Response {
    case success(user: User)
}
