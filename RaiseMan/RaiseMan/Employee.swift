//
//  Employee.swift
//  RaiseMan
//
//  Created by 但 江 on 15/10/10.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Foundation

class Employee: NSObject, NSCoding {
    
    var name: String? = "New Employee"
    var raise: Float = 0.05
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String?
        raise = aDecoder.decodeFloatForKey("raise")
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    func validateRaise(raiseNumberPointer: AutoreleasingUnsafeMutablePointer<NSNumber?>) throws {
        let raiseNumber = raiseNumberPointer.memory
        if raiseNumber == nil {
            let domain = "UserInputValidationErrorDomain"
            let code = 0
            let userInfo = [NSLocalizedDescriptionKey : "An employee`s raise must be a number."]
            throw NSError(domain: domain, code: code, userInfo: userInfo)
        }
    }
    
    // MARK: - NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let name = name {
            aCoder.encodeObject(name, forKey: "name")
        }
        aCoder.encodeFloat(raise, forKey: "raise")
    }
    
}