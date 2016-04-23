//
//  ScheduleFetcherTests.swift
//  RanchForecast
//
//  Created by 但 江 on 15/10/16.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import XCTest

class ScheduleFetcherTests: XCTestCase {
    
    var fetcher: ScheduleFetcher!
    
    override func setUp() {
        super.setUp()
        fetcher = ScheduleFetcher()
    }
    
    override func tearDown() {
        fetcher = nil
        super.tearDown()
    }

}