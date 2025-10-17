//
//  PlaybackQueueManager.swift
//  example-implementations
//
//  Created by Oscar Nowell on 17/10/2025.
//

import Foundation

class PlaybackQueueManager {
    
    // holds users playback queue of media items in an ordered array
    var currentlyPlayingQueue: [MediaItem] = []
    
    // expose state of currentlyPlayingMedia item in form of media items id
    
    // public method for adding media item to the queue
    func addToQueue(add mediaItem: MediaItem) {
        currentlyPlayingQueue.append(mediaItem)
    }
    
    // public method for playing next
    
    // public method for playing previous
    
    
}

// media item struct containing id, title and durationInSeconds
struct MediaItem: Equatable {
    let id: String
    let title: String
    let durationInSeconds: Int
}
