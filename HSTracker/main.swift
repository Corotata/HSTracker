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
var appDelegateClass: AnyClass?
var inTestMode = false
if let testDelegate = NSClassFromString("TestAppDelegate") {
    appDelegateClass = testDelegate
    inTestMode = true
} else {
    appDelegateClass = AppDelegate.self
}

let application = NSApplication.shared()

if let delegateType = (appDelegateClass as? NSObject.Type) {
    let delegate = delegateType.init()
    application.delegate = delegate as? NSApplicationDelegate
    
    if !inTestMode {
        if bundle.loadNibNamed("MainMenu", owner: application, topLevelObjects: nil) {
            
            application.run()
            
        } else {
            print("Unknown error occured while starting the application.")
        }
    } else {
        application.run()
    }
    
}
