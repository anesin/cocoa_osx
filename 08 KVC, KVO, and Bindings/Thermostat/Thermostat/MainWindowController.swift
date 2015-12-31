//
//  MainWindowController.swift
//  Thermostat
//
//  Created by anesin on 2015. 12. 4..
//  Copyright © 2015년 anesin. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
//    var temperature = 68  // fahrenheit
//    dynamic var temperature = 68  // fahrenheit
    private var privateTemperature = 68
    dynamic var temperature: Int {
        set {
            print("set temperature to \(newValue)")
            privateTemperature = newValue
        }
        get {
            print("get temperature")
            return privateTemperature
        }
    }
    dynamic var isOn = true

    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }

    // It's except for setVale(nil, forKey: "temperature")
    override func setNilValueForKey(key: String) {
        switch key {
            case "temperature":
                temperature = 68
        default:
            super.setNilValueForKey(key)
        }
    }
    
    @IBAction func makeWarmer(sender: NSButton) {
//        let newTemperature = temperature + 1
//        setValue(newTemperature, forKey: "temperature")
//        willChangeValueForKey("temperature")
        temperature++
//        didChangeValueForKey("temperature")
    }
    
    @IBAction func makeCooler(sender: NSButton) {
//        let newTemperature = temperature - 1
//        setValue(newTemperature, forKey: "temperature")
//        willChangeValueForKey("temperature")
        temperature--
//        didChangeValueForKey("temperature")
    }
    
}
