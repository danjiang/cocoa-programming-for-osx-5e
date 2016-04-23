//
//  CarArrayController.swift
//  CarLot
//
//  Created by 但 江 on 15/10/13.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

class CarArrayController: NSArrayController {

    override func newObject() -> AnyObject {
        let newObj = super.newObject() as! NSObject
        let now = NSDate()
        newObj.setValue(now, forKey: "datePurchased")
        return newObj
    }
}
