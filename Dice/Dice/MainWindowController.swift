//
//  MainWindowController.swift
//  Dice
//
//  Created by 但 江 on 15/10/14.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    var configurationWindowController: ConfigurationWindowController?
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    // MARK: - Actions
    
    @IBAction func showDieConfiguration(sender: AnyObject) {
        if let window = window, let dieView = window.firstResponder as? DieView {
            let windowController = ConfigurationWindowController()
            windowController.configuration = DieConfiguration(color: dieView.color, rolls: dieView.numberOfTimesToRoll)
            window.beginSheet(windowController.window!, completionHandler: { response in
                if response == NSModalResponseOK {
                    let configuration = self.configurationWindowController!.configuration
                    
                    dieView.color = configuration.color
                    dieView.numberOfTimesToRoll = configuration.rolls
                }
                self.configurationWindowController = nil
            })
            configurationWindowController = windowController
        }
    }
    
}
