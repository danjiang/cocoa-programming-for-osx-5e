//
//  ImageViewController.swift
//  ViewControl
//
//  Created by 但 江 on 15/10/16.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

class ImageViewController: NSViewController, ImageRepresentable {

    var image: NSImage?
    
    override var nibName: String? {
        return "ImageViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
