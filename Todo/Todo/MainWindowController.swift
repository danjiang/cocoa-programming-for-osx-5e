//
//  MainWindowController.swift
//  Todo
//
//  Created by 但 江 on 15/10/9.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSTableViewDataSource {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    var items = ["Buy garden", "Buy new car", "Buy house in the hills"]
    
    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return items.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return items[row]
    }
    
    // MARK: - Actions
    
    @IBAction func add(sender: NSButton) {
        if !textField.stringValue.isEmpty {
            items.append(textField.stringValue)
        }
        tableView.reloadData()
    }
    
}
