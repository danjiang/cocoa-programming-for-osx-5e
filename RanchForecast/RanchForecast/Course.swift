//
//  Course.swift
//  RanchForecast
//
//  Created by 但 江 on 15/10/15.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Foundation

public class Course: NSObject {
    public let title: String
    public let url: NSURL
    public let nextStartDate: NSDate
    
    public init(title: String, url: NSURL, nextStartDate: NSDate) {
        self.title = title
        self.url = url
        self.nextStartDate = nextStartDate
        super.init()
    }
}
