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
    
    override var nibName: String? {
        return "ImageViewController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func resizeImage() {
        let size = view.frame.size
        let width = size.width - 40
        let height = size.height - 40

        if width > 0 && height > 0 {
            view.subviews[0].hidden = false
            view.subviews[0].setFrameSize(NSSize(width: width, height: height))
        } else {
            view.subviews[0].hidden = true
        }
    }
    
}
