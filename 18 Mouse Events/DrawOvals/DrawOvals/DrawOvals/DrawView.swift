//
//  DrawView.swift
//  DrawOvals
//
//  Created by anesin on 2016. 2. 11..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

class DrawView: NSView {
    
    var begin: NSPoint?
    var end: NSPoint?
    var rects = [NSRect]()

    override func drawRect(dirtyRect: NSRect) {
        NSColor.lightGrayColor().set()
        NSBezierPath.fillRect(bounds)
        
        drawOvals()
    }
    
    func drawOvals() {
        NSColor.whiteColor().set()
        for rect in rects {
            NSBezierPath(ovalInRect: rect).stroke()
        }
    }
    
    func appendOval() {
        if let begin = begin, end = end {
            let w = end.x - begin.x
            let h = end.y - begin.y
            let rect = NSRect(x: begin.x, y: begin.y, width: w, height: h)
            rects.append(rect)
        }
        begin = nil
        end = nil
        needsDisplay = true
    }
    
    // MARK: - Mouse Events
    
    override func mouseDown(theEvent: NSEvent) {
        Swift.print("mouseDown location: \(theEvent.locationInWindow)")
        begin = convertPoint(theEvent.locationInWindow, fromView: nil)
        Swift.print("mouseDown begin: \(begin!)")
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        //Swift.print("mouseDragged location: \(theEvent.locationInWindow)")
    }
    
    override func mouseUp(theEvent: NSEvent) {
        Swift.print("mouseUp location: \(theEvent.locationInWindow)")
        end = convertPoint(theEvent.locationInWindow, fromView: nil)
        Swift.print("mouseDown end: \(end!)")
        appendOval()
    }
    
}
