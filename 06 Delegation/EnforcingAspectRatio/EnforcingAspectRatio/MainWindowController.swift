//
//  MainWindowController.swift
//  EnforcingAspectRatio
//
//  Created by anesin on 2015. 11. 22..
//  Copyright © 2015년 anesin. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {

    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    // MARK: - NSWindowDelegate

    func windowWillResize(sender: NSWindow, toSize frameSize: NSSize) -> NSSize {
        var size = frameSize
        size.width = size.height * 2
        sender.aspectRatio = size
        return size
    }
    
}
