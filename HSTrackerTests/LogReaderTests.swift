//
//  LogReaderTests.swift
//  HSTracker
//
//  Created by Istvan Fehervari on 15/02/2017.
//  Copyright © 2017 Benjamin Michotte. All rights reserved.
//

import Foundation
import XCTest
import SwiftDate

@testable import HSTracker

class MockAppDelegate: NSObject, NSApplicationDelegate {
    
}


@available(OSX 10.11, *)
class LogReaderTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLeak() {
        
        var entities: [Int: Entity] = [:]
        
        for i in 1 ... 1000 {
            let entity = Entity(id: i)
            entity.name = "GameEntity"
            entities[i] = entity
        }
        
        let replay = ReplayKeyPoint(data: entities.map { $0.1 },
                                    type: .play,
                                    id: 1,
                                    player: .player)
        print(replay)
        
        Thread.sleep(forTimeInterval: 3)
        
    }
    
    func testLogReaderManager() {
        let testBundle = Bundle(for: type(of: self))
        guard let logPath = testBundle.path(forResource: "Logs", ofType: nil) else {
            XCTFail()
            return
        }
        
        let manager = LogReaderManager(rootPath: (logPath as NSString).deletingLastPathComponent, cleanUpLogFiles: false)
        
        manager.start(asynch: false)
    }
    
    func testPowerLogReader() {
        
        // get power log file from bundle
        let testBundle = Bundle(for: type(of: self))
        let logPath = testBundle.path(forResource: "Logs", ofType: nil)
        
        XCTAssert(logPath != nil)
        
        let rx = "GameState.DebugPrintEntityChoices\\(\\)\\s-\\sid=(\\d) Player=(.+) TaskList=(\\d)"
        let plReader = LogReaderInfo(name: .power,
                                     startsWithFilters: ["PowerTaskList.DebugPrintPower", rx],
                                     containsFilters: ["Begin Spectating", "Start Spectator",
                                                       "End Spectator"])
        let powerLog = LogReader(info: plReader, logPath: logPath!, cleanUpLogFile: false)
        
        // find entry point
        powerLog.startingPoint = powerLog.findEntryPoint(choices:
            ["tag=GOLD_REWARD_STATE", "End Spectator"])
        
        // XCTAssert(powerLog.startingPoint.description == "30 Dec 1, 01:05:21 GMT+1:05:21")
        powerLog.read()
    }

}
