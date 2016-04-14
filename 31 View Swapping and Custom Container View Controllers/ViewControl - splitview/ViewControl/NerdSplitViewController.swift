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
    
    let kMax = 2

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
        
        let divider = NSBox()
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
            addVisualFormatConstraints("H:|[first(==second)][divider(==2)][second(==first)]|")
            addVisualFormatConstraints("V:|[first]|")
            addVisualFormatConstraints("V:|[divider]|")
            addVisualFormatConstraints("V:|[second]|")
        } else if direction == .kHorizontally {
            addVisualFormatConstraints("V:|[first(==second)][divider(==2)][second(==first)]|")
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
    
}
