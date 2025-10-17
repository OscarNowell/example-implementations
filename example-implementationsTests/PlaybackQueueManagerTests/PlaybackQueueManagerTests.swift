//
//  PlaybackQueueManagerTests.swift
//  example-implementationsTests
//
//  Created by Oscar Nowell on 17/10/2025.
//

import XCTest

@testable import example_implementations

@MainActor
final class PlaybackQueueManagerTests: XCTestCase {
    
    var sut: PlaybackQueueManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = PlaybackQueueManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_playbackQueueManager_hasCurrentlyPlayingQueue() throws {
        XCTAssertNotNil(sut.mediaItemQueue)
    }
    
    func test_playbackQueueManager_addToQueue_addsMediaItemToQueue() throws {
        let expectedMediaItem = MediaItem(id: "1", title: "title", durationInSeconds: 10)
        
        sut.addToQueue(add: expectedMediaItem)
        
        XCTAssertEqual(sut.mediaItemQueue[0], expectedMediaItem)
    }
    
    func test_playbackQueueManager_addToQueue_addsMediaItemToEndOfQueue() throws {
        let existingMediaItem = MediaItem(id: "2", title: "title", durationInSeconds: 10)
        sut.addToQueue(add: existingMediaItem)
        
        let expectedMediaItem = MediaItem(id: "1", title: "title", durationInSeconds: 10)
        
        sut.addToQueue(add: expectedMediaItem)
        
        XCTAssertEqual(sut.mediaItemQueue.last, expectedMediaItem)
    }
    
    func test_playbackQueueManager_playNext_changesCurrentlyPlayingIndexToNextItem() throws {
        let existingMediaItem = MediaItem(id: "2", title: "title", durationInSeconds: 10)
        sut.addToQueue(add: existingMediaItem)
        
        let expectedMediaItem = MediaItem(id: "1", title: "title", durationInSeconds: 10)
        
        sut.addToQueue(add: expectedMediaItem)
        
        sut.playNext()
        
        XCTAssertEqual(sut.currentlyPlayingMediaIndex, 1)
    }
    
    func test_playbackQueueManager_playPrevious_changesCurrentlyPlayingIndexToPreviousItem() throws {
        let existingMediaItem = MediaItem(id: "2", title: "title", durationInSeconds: 10)
        sut.addToQueue(add: existingMediaItem)
        
        let expectedMediaItem = MediaItem(id: "1", title: "title", durationInSeconds: 10)
        
        sut.addToQueue(add: expectedMediaItem)
        
        sut.playPrevious()
        
        XCTAssertEqual(sut.currentlyPlayingMediaIndex, -1)
    }
    
    func test_playbackQueueManager_currentlyPlayingItem_isNullIfIndexOutOfBounds() throws {
        XCTAssertNil(sut.currentlyPlayingItem)
    }
    
    func test_playbackQueueManager_currentlyPlayingItem_returnsCorrectItemForIndex() throws {
        let existingMediaItem = MediaItem(id: "2", title: "title", durationInSeconds: 10)
        sut.addToQueue(add: existingMediaItem)
        
        let expectedMediaItem = MediaItem(id: "1", title: "title", durationInSeconds: 10)
        
        sut.addToQueue(add: expectedMediaItem)
        
        XCTAssertEqual(existingMediaItem, sut.currentlyPlayingItem)
    }
    
    func test_playbackQueueManager_playNext_whenEmptyDoesNothing() throws {
      //  let expectedIndex 
    }
}
