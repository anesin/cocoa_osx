//
//  NerdSplitViewController.swift
//  ViewControl
//
//  Created by anesin on 2016. 4. 14..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

class NerdSplitViewController : NSViewController {

    enum Direction {
        case kVertically, kHorizontally
    }
    
    var direction: Direction = .kVertically
    
    var firstView: NSView?
    var secondView: NSView?
    var divider = NSBox()
    
    let kMax = 2
    
    var draggable = false
    var oldLocation: NSPoint?
    let dividerRegion: CGFloat = 10
    let viewMargin: CGFloat = 70

    override func loadView() {
        view = NSView()
        reset()
    }
    
    func reset() {
        if childViewControllers.count != kMax {
            return
        }

        view.subviews = []
        
        firstView?.removeFromSuperview()
        firstView = childViewControllers[0].view
        firstView!.translatesAutoresizingMaskIntoConstraints = false
        
        divider.removeFromSuperview()
        divider.boxType = .Separator
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        secondView?.removeFromSuperview()
        secondView = childViewControllers[1].view
        secondView!.translatesAutoresizingMaskIntoConstraints = false

        view.subviews = [firstView!, divider, secondView!]
        
        let views = ["first": firstView!, "divider": divider, "second": secondView!]
        func addVisualFormatConstraints(visualFormat:String) {
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: [], metrics: nil, views: views))
        }
        if direction == .kVertically {
            addVisualFormatConstraints("H:|[first(==second)][divider(==1)][second]|")
            addVisualFormatConstraints("V:|[first]|")
            addVisualFormatConstraints("V:|[divider]|")
            addVisualFormatConstraints("V:|[second]|")
        } else if direction == .kHorizontally {
            addVisualFormatConstraints("V:|[first(==second)][divider(==1)][second]|")
            addVisualFormatConstraints("H:|[first]|")
            addVisualFormatConstraints("H:|[divider]|")
            addVisualFormatConstraints("H:|[second]|")
        }
    }
    
    override func insertChildViewController(childViewController: NSViewController, atIndex index: Int) {
        super.insertChildViewController(childViewController, atIndex: index)
        if viewLoaded {
            reset()
        }
    }
    
    override func removeChildViewControllerAtIndex(index: Int) {
        super.removeChildViewControllerAtIndex(index)
        if viewLoaded {
            reset()
        }
    }

    // MARK: - Mouse Events
    
    override func mouseDown(theEvent: NSEvent) {
        draggable = false
        if direction == .kVertically {
            let x1 = divider.frame.origin.x
            let x2 = theEvent.locationInWindow.x
            if x1 - dividerRegion <= x2 && x2 <= x1 + dividerRegion {
                draggable = true
            }
        } else if direction == .kHorizontally {
            let y1 = divider.frame.origin.y
            let y2 = theEvent.locationInWindow.y
            if y1 - dividerRegion <= y2 && y2 <= y1 + dividerRegion {
                draggable = true
            }
        }
        oldLocation = theEvent.locationInWindow
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        if !draggable {
            return
        }
        
        let frame = marginFrame(view.frame, margin: viewMargin)
        if !frame.contains(theEvent.locationInWindow) {
            return
        }
        
        var origin = divider.frame.origin
        if direction == .kVertically {
            let move = theEvent.locationInWindow.x - oldLocation!.x
            origin.x += move
            resizeFirstView(move)
            resizeSecondView(move)
        } else if direction == .kHorizontally {
            let move = theEvent.locationInWindow.y - oldLocation!.y
            origin.y += move
            resizeFirstView(move)
            resizeSecondView(move)
        }
        divider.setFrameOrigin(origin)
        oldLocation = theEvent.locationInWindow
    }
    
    func marginFrame(rect: NSRect, margin: CGFloat) -> NSRect {
        var frame = rect
        frame.origin.x += margin
        frame.origin.y += margin
        frame.size.width -= margin*2
        frame.size.height -= margin*2
        return frame
    }
    
    func resizeFirstView(move: CGFloat) {
        if let firstView = firstView {
            var frame = firstView.frame
            if direction == .kVertically {
                frame.size.width += move
            } else if direction == .kHorizontally {
                frame.origin.y += move
                firstView.setFrameOrigin(frame.origin)
                frame.size.height -= move
            }
            firstView.setFrameSize(frame.size)
            let firstViewController = childViewControllers[0] as! ImageViewController
            firstViewController.resizeImage()
        }
    }
    
    func resizeSecondView(move: CGFloat) {
        if let secondView = secondView {
            var frame = secondView.frame
            if direction == .kVertically {
                frame.origin.x += move
                secondView.setFrameOrigin(frame.origin)
                frame.size.width -= move
            } else if direction == .kHorizontally {
                frame.size.height += move
            }
            secondView.setFrameSize(frame.size)
            let secondViewController = childViewControllers[1] as! ImageViewController
            secondViewController.resizeImage()
        }
    }
    
    override func mouseUp(theEvent: NSEvent) {
        draggable = false
        oldLocation = nil
    }
    
}
