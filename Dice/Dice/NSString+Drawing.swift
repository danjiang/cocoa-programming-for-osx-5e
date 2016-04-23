//
//  NSString+Drawing.swift
//  Dice
//
//  Created by 但 江 on 15/10/14.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

extension NSString {
    
    func drawCenteredInRect(rect: NSRect, attributes: [String: AnyObject]?) {
        let stringSize = sizeWithAttributes(attributes)
        let point = NSPoint(x: rect.origin.x + (rect.width - stringSize.width) / 2.0, y: rect.origin.y + (rect.height - stringSize.height) / 2.0)
        drawAtPoint(point, withAttributes: attributes)
    }
}