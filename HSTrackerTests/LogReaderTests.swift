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
        //NSApplication.shared().delegate = MockAppDelegate()
    }
    
    override func tearDown() {
        super.tearDown()
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
        print(powerLog.startingPoint)
        XCTAssert(powerLog.startingPoint.description == "30 Dec 1, 01:05:21 GMT+1:05:21")
        
        
        
        
        /*
        let asyncExpectation = expectation(description: "hearthArenaDeckImportAsynchTest")
        let url = "http://www.heartharena.com/arena-run/260979"
        do {
            try NetImporter.netImport(url: url, completion: { (deck) -> Void in
                XCTAssertNotNil(deck, "Deck should not be nil")
                asyncExpectation.fulfill()
            })
            
            self.waitForExpectations(timeout: importTimeout) { error in
                XCTAssertNil(error, "Connection timed out after \(self.importTimeout) seconds")
            }
        } catch {
            XCTFail("Deck should not be nil")
        }*/
    }

}
