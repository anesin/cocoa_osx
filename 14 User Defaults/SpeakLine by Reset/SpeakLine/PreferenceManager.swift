//
//  PreferenceManager.swift
//  SpeakLine
//
//  Created by anesin on 2016. 1. 16..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

private let activeVoiceKey = "activeVoice"
private let activeTextKey = "activeText"
private let activeTextDefault = "Able was I ere I saw Elba."

class PreferenceManager {
    
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    init() {
        registerDefaultPreferences()
    }
    
    func registerDefaultPreferences() {
        let defaults = [ activeVoiceKey: NSSpeechSynthesizer.defaultVoice(), activeTextKey: activeTextDefault ]
        userDefaults.registerDefaults(defaults)
    }
    
    func resetDefaultPreferences() {
        activeVoice = NSSpeechSynthesizer.defaultVoice()
        activeText = activeTextDefault
    }
    
    var activeVoice: String? {
        set (newActiveVoice) {
            userDefaults.setObject(newActiveVoice, forKey: activeVoiceKey)
        }
        get {
            return userDefaults.objectForKey(activeVoiceKey) as? String
        }
    }
    
    var activeText: String? {
        set (newActiveText) {
            userDefaults.setObject(newActiveText, forKey: activeTextKey)
        }
        get {
            return userDefaults.objectForKey(activeTextKey) as? String
        }
    }
    
}