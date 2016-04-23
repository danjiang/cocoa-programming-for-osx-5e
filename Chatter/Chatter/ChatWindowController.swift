//
//  ChatWindowController.swift
//  Chatter
//
//  Created by 但 江 on 15/10/13.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

private let ChatWindowControllerDidSendMessageNotification = "com.danthought.chatter.ChatWindowControllerDidSendMessageNotification"
private let ChatWindowControllerMessageKey = "com.danthought.chatter.ChatWindowControllerMessageKey"

class ChatWindowController: NSWindowController {

    dynamic var log: NSAttributedString = NSAttributedString()
    dynamic var message: String?
    
    @IBOutlet var textView: NSTextView!
    
    override var windowNibName: String? {
        return "ChatWindowController"
    }
    
    deinit {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self)
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "receiveDidSendMessageNotification:", name: ChatWindowControllerDidSendMessageNotification, object: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func send(sender: NSButton) {
        sender.window?.endEditingFor(nil)
        if let message = message {
            let userInfo = [ChatWindowControllerMessageKey : message]
            let notificationCenter = NSNotificationCenter.defaultCenter()
            notificationCenter.postNotificationName(ChatWindowControllerDidSendMessageNotification, object: self, userInfo: userInfo)
        }
        message = ""
    }
    
    // MARK: - Notifications
    
    func receiveDidSendMessageNotification(note: NSNotification) {
        let mutableLog = log.mutableCopy() as! NSMutableAttributedString
        
        if log.length > 0 {
            mutableLog.appendAttributedString(NSAttributedString(string: "\n"))
        }
        
        let userInfo = note.userInfo! as! [String : String]
        let message = userInfo[ChatWindowControllerMessageKey]!
        
        let logLine = NSAttributedString(string: message)
        mutableLog.appendAttributedString(logLine)
        
        log = mutableLog.copy() as! NSAttributedString
        
        textView.scrollRangeToVisible(NSRange(location: log.length, length: 0))
    }

}
