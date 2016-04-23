//
//  MainWindowController.swift
//  RandomPassword
//
//  Created by 但 江 on 15/9/8.
//  Copyright (c) 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet weak var textField: NSTextField!
    
    deinit {
        print("\(self) will be deallocated\n")
    }
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        print("window loaded from NIB named \(windowNibName)\n")
    }
    
    @IBAction func generatePassword(sender: AnyObject) {
        let length = 8
        let password = generateRandomString(length)
        
        textField.stringValue = password
    }

}
