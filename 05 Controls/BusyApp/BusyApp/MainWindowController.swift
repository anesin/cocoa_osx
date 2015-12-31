//
//  MainWindowController.swift
//  BusyApp
//
//  Created by anesin on 2015. 11. 14..
//  Copyright © 2015년 anesin. All rights reserved.
//

import Cocoa


class MainWindowController: NSWindowController {
    
    var sliderValue = 50
    
    @IBOutlet weak var slider: NSSlider!
    @IBOutlet weak var textSlider: NSTextField!
    @IBOutlet weak var showSliderTick: NSButton!
    @IBOutlet weak var hideSliderTick: NSButton!

    @IBOutlet weak var checkButton: NSButton!
    
    @IBOutlet weak var textSecured: NSSecureTextField!
    @IBOutlet weak var textRegular: NSTextField!

    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        reset()
    }
    
    func reset() {
        slider.integerValue = 50
        slider.numberOfTickMarks = 10
        textSlider.stringValue = ""
        showSliderTick.state = 1
        hideSliderTick.state = 0
        checkButton.state = 1;
        checkButton.title = "Uncheck me"
        textSecured.stringValue = "";
        textRegular.stringValue = "";
    }
    
    
    @IBAction func resetControls(sender: NSButton) {
        reset()
    }
    
    
    @IBAction func sliderMove(sender: NSSlider) {
        if sender.integerValue < sliderValue {
            textSlider.stringValue = "Slider goes down!"
        } else if sender.integerValue > sliderValue {
            textSlider.stringValue = "Slider goes up!"
        }
        sliderValue = sender.integerValue
    }
    
    @IBAction func sliderTickMarks(sender: NSButton) {
        if sender.tag == 0 {
            slider.numberOfTickMarks = 0
            showSliderTick.state = 0
        } else {
            slider.numberOfTickMarks = 10
            hideSliderTick.state = 0
        }
    }
    
    
    @IBAction func checkMe(sender: NSButton) {
        if sender.state == 0 {
            checkButton.title = "Check me"
        } else {
            checkButton.title = "Uncheck me"
        }
    }
    
    
    @IBAction func revealText(sender: NSButton) {
        textRegular.stringValue = textSecured.stringValue
    }
    
}