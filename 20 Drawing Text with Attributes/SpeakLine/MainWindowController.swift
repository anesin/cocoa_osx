//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by anesin on 2015. 11. 22..
//  Copyright © 2015년 anesin. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate, NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    let speechSynth = NSSpeechSynthesizer()

    let voices = NSSpeechSynthesizer.availableVoices()
    
    var isStarted: Bool = false {
        didSet {
            updateButtons()
            updateTextField()
        }
    }
    
    override var windowNibName: String {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        updateButtons()
        updateTextField()
        speechSynth.delegate = self
        for voice in voices {
            print(voiceNameForIdentifier(voice)!)
        }
        
        let defaultVoice = NSSpeechSynthesizer.defaultVoice()
        if let defaultRow = voices.indexOf(defaultVoice) {
            let indices = NSIndexSet(index: defaultRow)
            tableView.selectRowIndexes(indices, byExtendingSelection: false)
            tableView.scrollRowToVisible(defaultRow)
        }
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
    
    func updateTextField() {
        if isStarted {
            textField.enabled = false
        } else {
            textField.enabled = true
            textField.becomeFirstResponder()
        }
    }
    
    func voiceNameForIdentifier(identifier: String) -> String? {
        let attributes = NSSpeechSynthesizer.attributesForVoice(identifier)
        return attributes[NSVoiceName] as? String
    }
    
    // MARK: - NSSpeechSynthesizerDelete
    
    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        isStarted = false
        print("finishedSpeaking=\(finishedSpeaking)")
    }
    
    func speechSynthesizer(sender: NSSpeechSynthesizer, willSpeakWord characterRange: NSRange, ofString string: String) {
        let attributedString = NSMutableAttributedString(string: string)
        let fontManager = NSFontManager.sharedFontManager()
        let boldFont = fontManager.convertFont(NSFont.systemFontOfSize(0.0), toHaveTrait: NSFontTraitMask.BoldFontMask)
        let attrs = [NSForegroundColorAttributeName: NSColor.blackColor(), NSFontAttributeName: boldFont]
        attributedString.addAttributes(attrs, range: characterRange)
        textField.attributedStringValue = attributedString
    }
    
    // MARK: - NSWindowDelegate
    
    func windowShouldClose(sender: AnyObject) -> Bool {
        return !isStarted
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return voices.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let voice = voices[row]
        print("voices[\(row)]=\(voice)")
        return voiceNameForIdentifier(voice)
    }
    
    // MARK: - NSTableViewDelegate
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let row = tableView.selectedRow
        if row == -1 {
            speechSynth.setVoice(nil)
            return
        }
        
        let voice = voices[row]
        speechSynth.setVoice(voice)
    }
    
}
