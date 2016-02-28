//
//  ConfigurationWindowController.swift
//  Dice
//
//  Created by anesin on 2016. 2. 27..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

struct DieConfiguration {
    let color: NSColor
    let rolls: Int
    
    init(color: NSColor, rolls: Int) {
        self.color = color
        self.rolls = max(rolls, 1)
    }
}

class ConfigurationWindowController: NSWindowController {
    
    var configuration: DieConfiguration {
        set {
            color = newValue.color
            rolls = newValue.rolls
        }
        get {
            return DieConfiguration(color: color, rolls: rolls)
        }
    }

    private dynamic var color: NSColor = NSColor.whiteColor()
    private dynamic var rolls: Int = 10
    
    override var windowNibName: String {
        return "ConfigurationWindowController"
    }
    
    @IBAction func okayButtonClicked(button: NSButton) {
        window?.endEditingFor(nil)
        dismissWithModalResponse(NSModalResponseOK)
    }
    
    @IBAction func cancelButtonClicked(button: NSButton) {
        dismissWithModalResponse(NSModalResponseCancel)
    }
    
    func dismissWithModalResponse(response: NSModalResponse) {
        window!.sheetParent!.endSheet(window!, returnCode: response)
    }
    
    func presentAsSheetOnWindow(window: NSWindow, completionHandler: ((DieConfiguration?) -> Void)) {
        window.beginSheet(self.window!, completionHandler: { response in
            // The sheet has finished. Did the user click 'OK'?
            if response == NSModalResponseOK {
                completionHandler(self.configuration)
            }
        })
    }
    
}
