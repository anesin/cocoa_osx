//
//  NerdTabViewController.swift
//  ViewControl
//
//  Created by anesin on 2016. 4. 14..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

@objc
protocol ImageRepresentable {
    var image: NSImage? { get }
}

class NerdTabViewController : NSViewController {
    
    var boxless: NSView?
    var buttons: [NSButton] = []
    var stackView = NSStackView()
    var separator = NSBox()
    
    func selectTabAtIndex(index: Int) {
        assert(0 <= index && index < childViewControllers.count, "index out of range")
        for (i, button) in buttons.enumerate() {
            button.state = (index == i) ? NSOnState : NSOffState
        }
        let viewController = childViewControllers[index]
        boxless?.removeFromSuperview()
        boxless = viewController.view
        view.addSubview(boxless!)
        
        boxless?.translatesAutoresizingMaskIntoConstraints = false
        let views = ["separator": separator, "boxless": boxless!]
        addVisualFormatConstraints("H:|[boxless(>=100)]|", metrics: nil, views: views)
        addVisualFormatConstraints("V:[separator(==1)][boxless(>=100)]|", metrics: nil, views: views)
    }
    
    func selectTab(sender: NSButton) {
        let index = sender.tag
        selectTabAtIndex(index)
    }
    
    override func loadView() {
        view = NSView()
        reset()
    }
    
    func reset() {
        view.subviews = []
        
        let buttonWidth: CGFloat = 28
        let buttonHeight: CGFloat = 28
        
        let viewControllers = childViewControllers
        buttons = viewControllers.enumerate().map { (index, viewController) -> NSButton in
            let button = NSButton()
            button.setButtonType(.ToggleButton)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.bordered = false
            button.target = self
            button.action = #selector(NerdTabViewController.selectTab(_:))
            button.tag = index
//            button.image = NSImage(named: NSImageNameFlowViewTemplate)
            if let viewController = viewController as? ImageRepresentable {
                button.image = viewController.image
            } else {
                button.title = viewController.title!
            }
            button.addConstraints([
                NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: buttonWidth),
                NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: buttonHeight),
            ])
            return button
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .Horizontal
        stackView.spacing = 4
        for button in buttons {
            stackView.addView(button, inGravity: .Center)
        }
        
        separator.boxType = .Separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        view.subviews = [stackView, separator]
        
        let views = ["stack": stackView, "separator": separator]
        let metrics = ["buttonHeight": buttonHeight]
        
        addVisualFormatConstraints("H:|[stack]|", metrics: metrics, views: views)
        addVisualFormatConstraints("H:|[separator]|", metrics: metrics, views: views)
        addVisualFormatConstraints("V:|[stack(buttonHeight)][separator(==1)]", metrics: metrics, views: views)
        
        if childViewControllers.count > 0 {
            selectTabAtIndex(0)
        }
    }

    func addVisualFormatConstraints(visualFormat:String, metrics: [String: NSNumber]?, views: [String: AnyObject]) {
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: [], metrics: metrics, views: views))
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
