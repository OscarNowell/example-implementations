//
//  PlaybackQueueManagerTests.swift
//  example-implementationsTests
//
//  Created by Oscar Nowell on 17/10/2025.
//

import XCTest

@testable import example_implementations

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
        XCTAssertNotNil(sut.currentlyPlayingQueue)
    }
    
    func test_playbackQueueManager_addToQueue_addsMediaItemToQueue() throws {
        let expectedMediaItem = MediaItem(id: "1", title: "title", durationInSeconds: 10)
        
        sut.addToQueue(add: expectedMediaItem)
        
        XCTAssertEqual(sut.currentlyPlayingQueue[expectedMediaItem.id], expectedMediaItem)
    }
}
