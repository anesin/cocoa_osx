//
//  AppDelegate.swift
//  EnforcingAspectRatio
//
//  Created by anesin on 2015. 11. 22..
//  Copyright © 2015년 anesin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController: MainWindowController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        mainWindowController = MainWindowController()
        mainWindowController!.showWindow(self)
    }


}

