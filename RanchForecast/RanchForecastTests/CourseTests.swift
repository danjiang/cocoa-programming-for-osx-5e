//
//  CourseTests.swift
//  RanchForecast
//
//  Created by 但 江 on 15/10/16.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import XCTest
import RanchForecast

class CourseTests: XCTestCase {
    
    func testCourseInitialization() {
        let course = Course(title: Constants.title, url: Constants.url, nextStartDate: Constants.date)
        
        XCTAssertEqual(course.title, Constants.title)
        XCTAssertEqual(course.url, Constants.url)
        XCTAssertEqual(course.nextStartDate, Constants.date)
    }
    
}