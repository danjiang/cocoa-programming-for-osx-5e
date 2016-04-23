//
//  AppDelegate.swift
//  Chatter
//
//  Created by 但 江 on 15/10/13.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var windowControllers: [ChatWindowController] = []
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        addWindowController()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    // MARK: - Actions
    
    @IBAction func displayNewWindow(sender: NSMenuItem) {
        addWindowController()
    }
    
    // MARK: - Helpers

    func addWindowController() {
        let windowController = ChatWindowController()
        windowController.showWindow(self)
        windowControllers.append(windowController)
    }

}

