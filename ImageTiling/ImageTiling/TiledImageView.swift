//
//  TiledImageView.swift
//  ImageTiling
//
//  Created by 但 江 on 15/10/14.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

@IBDesignable class TiledImageView: NSView {

    @IBInspectable var image: NSImage?
    let columnCount = 5
    let rowCount = 5
    
    override var intrinsicContentSize: NSSize {
        let furthestFrame = frameForImageAtLogicalX(columnCount - 1, y: rowCount - 1)
        return NSSize(width: furthestFrame.maxX, height: furthestFrame.maxY)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        if let image = image {
            for x in 0..<columnCount {
                for y in 0..<rowCount {
                    let frame = frameForImageAtLogicalX(x, y: y)
                    image.drawInRect(frame)
                }
            }
        }
    }
    
    // MARK: - Drawing
    
    func frameForImageAtLogicalX(logicalX: Int, y logicalY: Int) -> CGRect {
        let spacing = 10
        let width = 100
        let height = 100
        let x = (spacing + width) * logicalX
        let y = (spacing + height) * logicalY
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
}
