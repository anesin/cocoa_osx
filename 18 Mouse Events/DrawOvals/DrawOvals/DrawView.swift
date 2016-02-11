//
//  DrawView.swift
//  DrawOvals
//
//  Created by anesin on 2016. 2. 11..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

class DrawView: NSView {
    
    var rects = [NSRect]()
    var begin: NSPoint?
    var end: NSPoint?

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
        
        if let rect = makeOval() {
            NSBezierPath(ovalInRect: rect).stroke()
        }
    }
    
    func appendOval() {
        if let rect = makeOval() {
            rects.append(rect)
        }
        begin = nil
        end = nil
    }
    
    func makeOval() -> NSRect? {
        if let begin = begin, end = end {
            let w = end.x - begin.x
            let h = end.y - begin.y
            return NSRect(x: begin.x, y: begin.y, width: w, height: h)
        }
        return nil
    }
    
    // MARK: - Mouse Events
    
    override func mouseDown(theEvent: NSEvent) {
        begin = convertPoint(theEvent.locationInWindow, fromView: nil)
        Swift.print("mouseDown begin: \(begin!)")
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        end = convertPoint(theEvent.locationInWindow, fromView: nil)
        Swift.print("mouseDragged end: \(end!)")
        needsDisplay = true
    }
    
    override func mouseUp(theEvent: NSEvent) {
        end = convertPoint(theEvent.locationInWindow, fromView: nil)
        Swift.print("mouseDown end: \(end!)")
        appendOval()
        needsDisplay = true
    }
    
}
