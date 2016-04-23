//
//  MainWindowController.swift
//  RGBWell
//
//  Created by 但 江 on 15/10/3.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    var r = 0.0 {
        didSet {
            updateColor()
        }
    }
    var g = 0.0 {
        didSet {
            updateColor()
        }
    }
    var b = 0.0 {
        didSet {
            updateColor()
        }
    }
    let a = 1.0
    
    @IBOutlet weak var colorWell: NSColorWell!
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        updateColor()
    }

    func updateColor() {
        let newColor = NSColor(calibratedRed: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
        colorWell.color = newColor
    }

}
