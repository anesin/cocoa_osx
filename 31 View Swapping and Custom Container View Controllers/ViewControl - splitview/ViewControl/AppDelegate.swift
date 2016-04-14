//
//  AppDelegate.swift
//  ViewControl
//
//  Created by anesin on 2016. 4. 9..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let verticallySplitViewController = createSplitViewController(.kVertically)
        let horizontallySplitViewController = createSplitViewController(.kHorizontally)

        let tabViewController = NSTabViewController()
        tabViewController.addChildViewController(verticallySplitViewController)
        tabViewController.addChildViewController(horizontallySplitViewController)
        
        let window = NSWindow(contentViewController: tabViewController)
        window.makeKeyAndOrderFront(self)
        self.window = window
    }
    
    func createSplitViewController(direction: NerdSplitViewController.Direction) -> NerdSplitViewController {
        let flowViewController = ImageViewController()
        flowViewController.title = "Flow"
        flowViewController.image = NSImage(named: NSImageNameFlowViewTemplate)
        let columnViewController = ImageViewController()
        columnViewController.title = "Column"
        columnViewController.image = NSImage(named: NSImageNameColumnViewTemplate)
        
        let splitViewController = NerdSplitViewController()
        splitViewController.direction = direction
        splitViewController.title = "Vertically"
        splitViewController.addChildViewController(flowViewController)
        splitViewController.addChildViewController(columnViewController)
        return splitViewController
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

