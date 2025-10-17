//
//  PlaybackQueueManager.swift
//  example-implementations
//
//  Created by Oscar Nowell on 17/10/2025.
//

import Foundation

class PlaybackQueueManager {
    
    // holds users playback queue of media items in an ordered array
    private(set) var mediaItemQueue: [MediaItem] = []
    
    // expose state of currentlyPlayingMedia item in form of media items id
    private(set) var currentlyPlayingMediaIndex: Int = -1
    
    var currentlyPlayingItem: MediaItem? {
        get {
            guard mediaItemQueue.indices.contains(currentlyPlayingMediaIndex) else {
                return nil
            }
            return mediaItemQueue[currentlyPlayingMediaIndex]
        }
    }
    
    // public method for adding media item to the queue
    func addToQueue(add mediaItem: MediaItem) {
        mediaItemQueue.append(mediaItem)
    }
    
    // public method for playing next
    func playNext() {
        
        guard mediaItemQueue.indices.contains(currentlyPlayingMediaIndex + 1) else { return }
        
        currentlyPlayingMediaIndex += 1
    }
    
    // public method for playing previous
    func playPrevious() {
        currentlyPlayingMediaIndex -= 1
    }
    
}

// media item struct containing id, title and durationInSeconds
struct MediaItem: Equatable {
    let id: String
    let title: String
    let durationInSeconds: Int
}
