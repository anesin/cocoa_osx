//
//  MainWindowController.swift
//  Dice
//
//  Created by anesin on 2016. 2. 6..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    // MARK: - Actions
    
    var configurationWindowController: ConfigurationWindowController?
    
    @IBAction func showDieConfiguration(sender: AnyObject?) {
        if let window = window, let dieView = window.firstResponder as? DieView {
            // Create and configure the window controller to present as a sheet:
            let windowController = ConfigurationWindowController()
            windowController.presentAsSheetOnWindow(window, completionHandler: { configuration in
                if let configuration = configuration {
                    dieView.color = configuration.color
                    dieView.numberOfTimesToRoll = configuration.rolls
                }
                // All done with the window controller.
                self.configurationWindowController = nil
            })
            configurationWindowController = windowController
        }
    }
    
}
