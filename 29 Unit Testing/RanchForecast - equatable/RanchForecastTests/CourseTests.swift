//
//  CourseTests.swift
//  RanchForecast
//
//  Created by anesin on 2016. 4. 2..
//  Copyright © 2016년 anesin. All rights reserved.
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
