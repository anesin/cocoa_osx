//
//  AppDelegate.swift
//  RanchForecast
//
//  Created by anesin on 3/24/16.
//  Copyright © 2016 anesin. All rights reserved.
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

