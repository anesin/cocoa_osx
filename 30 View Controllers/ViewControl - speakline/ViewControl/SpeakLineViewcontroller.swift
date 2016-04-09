//
//  SpeakLineViewcontroller.swift
//  ViewControl
//
//  Created by anesin on 2016. 4. 9..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

class SpeakLineViewcontroller: NSViewController, NSSpeechSynthesizerDelegate {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    
    let speechSynth = NSSpeechSynthesizer()
    
    var isStarted: Bool = false {
        didSet {
            updateButtons()
        }
    }
    
    override var nibName: String? {
        return "SpeakLineViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtons()
        speechSynth.delegate = self
    }
    
    override func viewWillDisappear() {
        speechSynth.stopSpeaking()
        super.viewWillDisappear()
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
    
}
