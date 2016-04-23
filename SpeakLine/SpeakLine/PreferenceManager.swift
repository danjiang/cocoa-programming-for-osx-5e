//
//  PreferenceManager.swift
//  SpeakLine
//
//  Created by 但 江 on 15/10/13.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

private let activeVoiceKey = "activeVoice"
private let activeTextKey = "activeText"

class PreferenceManager {
    
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    init() {
        registerDefaultPreferences()
    }

    func registerDefaultPreferences() {
        let defaults = [activeVoiceKey : NSSpeechSynthesizer.defaultVoice(), activeTextKey : "Able was I ere I saw Elba."]
        userDefaults.registerDefaults(defaults)
    }
    
    var activeVoice: String? {
        set(newActiveVoice) {
            userDefaults.setObject(newActiveVoice, forKey: activeVoiceKey)
        }
        get {
            return userDefaults.objectForKey(activeVoiceKey) as? String
        }
    }
    
    var activeText: String? {
        set(newActiveText) {
            userDefaults.setObject(newActiveText, forKey: activeTextKey)
        }
        get {
            return userDefaults.objectForKey(activeTextKey) as? String
        }
    }
    
}