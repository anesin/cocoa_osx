//
//  Constants.swift
//  RanchForecast
//
//  Created by anesin on 2016. 4. 2..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Foundation
import RanchForecast

class Constants {
    static let urlString = "http://training.bignerdranch.com/classes/test-course"
    static let url = NSURL(string: urlString)!
    static let title = "Test Course"
    
    static let dateString = "2014-06-02"
    static let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    static let date = dateFormatter.dateFromString(dateString)!
    
    static let validCourseDict = ["title" : title, "url" : urlString, "upcoming" : [["start_date" : dateString]]]
    
    static let coursesDictionary = ["courses" : [validCourseDict]]
    
    static let okResponse = NSHTTPURLResponse(URL: url, statusCode: 200, HTTPVersion: nil, headerFields: nil)
    
    static let jsonData = try! NSJSONSerialization.dataWithJSONObject(coursesDictionary, options: [])
    
    static let course = Course(title: Constants.title, url: Constants.url, nextStartDate: Constants.date)
}