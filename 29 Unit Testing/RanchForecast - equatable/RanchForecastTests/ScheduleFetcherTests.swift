//
//  ScheduleFetcherTests.swift
//  RanchForecast
//
//  Created by anesin on 2016. 4. 2..
//  Copyright © 2016년 anesin. All rights reserved.
//

import XCTest
import RanchForecast

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
    
    func testCreateCourseFromValidDictionary() {
        let course: Course! = fetcher.courseFromDictionary(Constants.validCourseDict)
        
        XCTAssertNotNil(course)
        XCTAssertTrue(course == Constants.course)  // using ==(_:_:)
        XCTAssertEqual(course, Constants.course)   // using isEqual:object:
    }
    
    func testResultFromValidHTTPResponseAndValidData() {
        let result = fetcher.resultFromData(Constants.jsonData, response: Constants.okResponse, error: nil)
        
        switch result {
        case .Success(let courses):
            XCTAssert(courses.count == 1)
            let theCourse = courses[0]
            XCTAssertTrue(theCourse == Constants.course)  // using ==(_:_:)
            XCTAssertEqual(theCourse, Constants.course)   // using isEqual:object:
        default:
            XCTFail("Result contains Failure, but Success was expected.")
        }
    }

}
