//
//  MainWindowController.swift
//  RGBWell
//
//  Created by anesin on 2015. 11. 14..
//  Copyright © 2015년 anesin. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    var r = 0.0 {
        didSet {
            color = updateColor()
        }
    }
    var g = 0.0 {
        didSet {
            color = updateColor()
        }
    }
    var b = 0.0 {
        didSet {
            color = updateColor()
        }
    }
    let a = 1.0
    
    lazy dynamic var color: NSColor = self.updateColor()
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    func updateColor() -> NSColor {
        return NSColor(calibratedRed: CGFloat(r),
                               green: CGFloat(g),
                                blue: CGFloat(b),
                               alpha: CGFloat(a))
    }
    
}