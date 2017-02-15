//
//  main.swift
//  HSTracker
//
//  Created by Istvan Fehervari on 15/02/2017.
//  Copyright © 2017 Benjamin Michotte. All rights reserved.
//

import Foundation
import Cocoa

let bundle: Bundle = Bundle.main

// replace production app delegate while testing
//let isRunningTests = NSClassFromString("XCTestCase") != nil

//print(NSClassFromString("HSTrackerTests.TestAppDelegate"))

let appDelegateClass: AnyClass? =
    NSClassFromString("HSTrackerTests.TestAppDelegate") ?? AppDelegate.self

let application = NSApplication.shared()

if let delegateType = (appDelegateClass as? NSObject.Type) {
    let delegate = delegateType.init()
    application.delegate = delegate as? NSApplicationDelegate
    
    if bundle.loadNibNamed("MainMenu", owner: application, topLevelObjects: nil) {
        
        application.run()
        
    } else {
        print("Unknown error occured while starting the application.")
    }
    
    application.run()
}
