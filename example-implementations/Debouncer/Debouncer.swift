//
//  Debouncer.swift
//  example-implementations
//
//  Created by Oscar Nowell on 17/10/2025.
//

import Foundation

class Debouncer{
    
    private let delay: Duration
    private var currentTask: Task<Void, Never>?
    
    init(delay: Duration) {
        self.delay = delay
    }
    
    // function for checking if the last key stroke was entered OVER 300ms ago
    // IF 300ms has passed, should execute API call with search query
    func debounce(action: @escaping () async -> Void) {
        currentTask?.cancel()
        
        currentTask = Task {
            do {
                
                try await Task.sleep(for: delay)
                
                await action()
                
            } catch {
                // task is cancelled
            }
        }
    }
}
