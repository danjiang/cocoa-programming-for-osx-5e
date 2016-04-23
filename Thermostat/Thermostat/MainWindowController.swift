//
//  MainWindowController.swift
//  Thermostat
//
//  Created by 但 江 on 15/10/10.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

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
    
    @IBAction func makeWarmer(sender: NSButton) {
        temperature++
    }
    
    @IBAction func makeCooler(sender: NSButton) {
        temperature--
    }
    
}
