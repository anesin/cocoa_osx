//
//  AppDelegate.swift
//  Chatter
//
//  Created by anesin on 2016. 1. 30..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var windowControllers: [ChatWindowController] = []

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        addWindowController()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    // MARK: - Actions
    
    @IBAction func displayNewWindow(sender: NSMenuItem) {
        addWindowController()
    }

    // MARK: - Helpers
    
    func addWindowController() {
        let windowController = ChatWindowController()
        windowController.showWindow(self)
        windowControllers.append(windowController)
    }

}

