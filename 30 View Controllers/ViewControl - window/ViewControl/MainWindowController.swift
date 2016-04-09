//
//  MainWindowController.swift
//  ViewControl
//
//  Created by anesin on 2016. 4. 9..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        let flowViewController = ImageViewController()
        flowViewController.title = "Flow"
        flowViewController.image = NSImage(named: NSImageNameFlowViewTemplate)
        let columnViewController = ImageViewController()
        columnViewController.title = "Column"
        columnViewController.image = NSImage(named: NSImageNameColumnViewTemplate)
        
        let tabViewController = NSTabViewController()
        tabViewController.addChildViewController(flowViewController)
        tabViewController.addChildViewController(columnViewController)
        
        self.contentViewController = tabViewController
    }
    
}
