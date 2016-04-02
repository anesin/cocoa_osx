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
        XCTAssertEqual(course.title, Constants.title)
        XCTAssertEqual(course.url, Constants.url)
        XCTAssertEqual(course.nextStartDate, Constants.date)
    }
    
    func testResultFromValidHTTPResponseAndValidData() {
        let result = fetcher.resultFromData(Constants.jsonData, response: Constants.okResponse, error: nil)
        
        switch result {
        case .Success(let courses):
            XCTAssert(courses.count == 1)
            let theCourse = courses[0]
            XCTAssertEqual(theCourse.title, Constants.title)
            XCTAssertEqual(theCourse.url, Constants.url)
            XCTAssertEqual(theCourse.nextStartDate, Constants.date)
        default:
            XCTFail("Result contains Failure, but Success was expected.")
        }
    }
    
    func testResultFromNotFoundHTTPResponseAndNoData() {
        let error = NSError(domain: "ScheduleFetcherTest", code: 1, userInfo: [NSLocalizedDescriptionKey: "Not Found Response and No Data"])
        let result = fetcher.resultFromData(nil, response: Constants.notFoundResponse, error: error)
        switch result {
        case .Failure(_):
            XCTAssert(true)
        default:
            XCTFail("Result contains Success, But Failure was expected.")
        }
    }
    
    func testResultFromValidHTTPResponseAndInvalidJsonData() {
        let result = fetcher.resultFromData(Constants.invalidJsonData, response: Constants.okResponse, error: nil)
        switch result {
        case .Failure(_):
            XCTAssert(true)
        default:
            XCTFail("Result contains Success, But Failure was expected.")
        }
    }

}
