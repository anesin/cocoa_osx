//
//  ImageViewController.swift
//  ViewControl
//
//  Created by anesin on 2016. 4. 9..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

class ImageViewController: NSViewController {
    
    var image: NSImage?
    
    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 450, height: 450))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = NSImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.imageScaling = .ScaleProportionallyUpOrDown
        view.addSubview(imageView)

        let views = ["imageView": imageView]
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("|[imageView]|", options: [], metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activateConstraints(horizontalConstraints)
        NSLayoutConstraint.activateConstraints(verticalConstraints)
    }
    
}
