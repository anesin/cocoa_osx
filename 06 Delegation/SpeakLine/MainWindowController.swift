//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by anesin on 2015. 11. 22..
//  Copyright © 2015년 anesin. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate, NSWindowDelegate {
    
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    
    let speechSynth = NSSpeechSynthesizer()
    
    var isStarted: Bool = false {
        didSet {
            updateButtons()
        }
    }
    
    override var windowNibName: String {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        updateButtons()
        speechSynth.delegate = self
    }
    
    // MARK: - Action methods
    
    @IBAction func speakIt(sender: NSButton) {
        // Get typed-in text as a string
        let string = textField.stringValue
        if string.isEmpty {
            print("string from \(textField) is empty")
        } else {
            //print("string is \"\(string)\"")
            speechSynth.startSpeakingString(string)
            isStarted = true
        }
    }
    
    @IBAction func stopIt(sender: NSButton) {
        //print("stop button clicked")
        speechSynth.stopSpeaking()
        //isStarted = false
    }
    
    func updateButtons() {
        if isStarted {
            speakButton.enabled = false
            stopButton.enabled = true
        } else {
            speakButton.enabled = true
            stopButton.enabled = false
        }
    }
    
    // MARK: - NSSpeechSynthesizerDelete
    
    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        isStarted = false
        print("finishedSpeaking=\(finishedSpeaking)")
    }
    
    // MARK: - NSWindowDelegate
    
    func windowShouldClose(sender: AnyObject) -> Bool {
        return !isStarted
    }
    
}
