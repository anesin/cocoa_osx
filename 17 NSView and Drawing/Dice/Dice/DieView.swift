//
//  DieView.swift
//  Dice
//
//  Created by anesin on 2016. 2. 6..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

class DieView: NSView {
    
    var intValue: Int? = 1 {
        didSet {
            needsDisplay = true
        }
    }
    
    override var intrinsicContentSize: NSSize {
        return NSSize(width: 20, height: 20)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        let backgroundColor = NSColor.lightGrayColor()
        backgroundColor.set()
        NSBezierPath.fillRect(bounds)
        
//        NSColor.greenColor().set()
//        let path = NSBezierPath()
//        path.moveToPoint(NSPoint(x: 0, y: 0))
//        path.lineToPoint(NSPoint(x: bounds.width, y: bounds.height))
//        path.stroke()
        
        drawDieWithSize(bounds.size)
    }
    
    func metricForSize(size: CGSize) -> (edgeLength: CGFloat, dieFrame: CGRect) {
        let edgeLength = min(size.width, size.height)
        let padding = edgeLength/10.0
        let drawingBounds = CGRect(x: 0, y: 0, width: edgeLength, height: edgeLength)
        let dieFrame = drawingBounds.insetBy(dx: padding, dy: padding)
        return (edgeLength, dieFrame)
    }
    
    func drawDieWithSize(size: CGSize) {
        if let intValue = intValue {
            let (edgeLength, dieFrame) = metricForSize(size)
            let cornerRadius: CGFloat = edgeLength/5.0
            let dotRadius = edgeLength/12.0
            let dotFrame = dieFrame.insetBy(dx: dotRadius*2.5, dy: dotRadius*2.5)
            
            NSGraphicsContext.saveGraphicsState()
            
            let shadow = NSShadow()
            shadow.shadowOffset = NSSize(width: 0, height: -1)
            shadow.shadowBlurRadius = edgeLength/20
            shadow.set()
            
            // Draw the rounded shape of the die profile:
            NSColor.whiteColor().set()
            NSBezierPath(roundedRect: dieFrame, xRadius: cornerRadius, yRadius: cornerRadius).fill()
            
            NSGraphicsContext.restoreGraphicsState()
            // Shadow will not apply to subsequent drawing commands
            
            // Ready to draw the dots.
            // The dots will be black:
            NSColor.blackColor().set()
            
            // Nested function to make drawing dots cleaner:
            func drawDot(u: CGFloat, v: CGFloat) {
                let dotOrigin = CGPoint(x: dotFrame.minX + dotFrame.width*u, y: dotFrame.minY + dotFrame.height*v)
                let dotRect = CGRect(origin: dotOrigin, size: CGSizeZero).insetBy(dx: -dotRadius, dy: -dotRadius)
                NSBezierPath(ovalInRect: dotRect).fill()
            }
            
            // If intValue is in range...
            if 1...6 ~= intValue {
                // Draw the dots:
                if [1, 3, 5].indexOf(intValue) != nil {
                    drawDot(0.5, v: 0.5)  // Center dot
                }
                if 2...6 ~= intValue {
                    drawDot(0, v: 1)  // Upper left
                    drawDot(1, v: 0)  // Lower right
                }
                if 4...6 ~= intValue {
                    drawDot(1, v: 1)  // Upper right
                    drawDot(0, v: 0)  // Lower left
                }
                if intValue == 6 {
                    drawDot(0, v: 0.5)  // Mid left/right
                    drawDot(1, v: 0.5)
                }
            }
        }
    }
    
}