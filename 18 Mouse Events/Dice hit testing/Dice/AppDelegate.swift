//
//  AppDelegate.swift
//  Dice
//
//  Created by Adam Preble on 8/22/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
	var mainWindowController: MainWindowController?

	func applicationDidFinishLaunching(aNotification: NSNotification) {
		// Insert code here to initialize your application
		mainWindowController = MainWindowController()
		mainWindowController!.showWindow(self)
	}

	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}


}

