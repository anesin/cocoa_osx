//
//  ScheduleFetcher.swift
//  RanchForecast
//
//  Created by anesin on 3/24/16.
//  Copyright © 2016 anesin. All rights reserved.
//

import Foundation

public class ScheduleFetcher {
    
    public enum FetchCoursesResult {
        case Success([Course])
        case Failure(NSError)
        
        init(throwingClosure: () throws -> [Course]) {
            do {
                let courses = try throwingClosure()
                self = .Success(courses)
            }
            catch {
                self = .Failure(error as NSError)
            }
        }
    }
    
    let session: NSURLSession
    
    public init() {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: config)
    }
    
    func fetchCoursesUsingCompletionHandler(completionHandler: (FetchCoursesResult) -> (Void)) {
        let url = NSURL(string: "http://bookapi.bignerdranch.com/courses.json")!
        let request = NSURLRequest(URL: url)
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            let result: FetchCoursesResult = self.resultFromData(data, response: response, error: error)
            NSOperationQueue.mainQueue().addOperationWithBlock({
                completionHandler(result)
            })
        })
        task.resume()
    }
    
    public func resultFromData(data: NSData!, response: NSURLResponse!, error: NSError!) -> FetchCoursesResult {
        var result: FetchCoursesResult
        if data == nil {
            result = .Failure(error!)
        }
        else if let response = response as? NSHTTPURLResponse {
            print("\(data!.length) bytes, HTTP \(response.statusCode).")
            if response.statusCode == 200 {
                //result = .Success([])  // Empty array until parsing in added
                result = FetchCoursesResult { try self.resultFromData(data!) }
            }
            else {
                let error = self.errorWithCode(1, localizeDescription: "Bad status code \(response.statusCode)")
                result = .Failure(error)
            }
        }
        else {
            let error = self.errorWithCode(1, localizeDescription: "Unexpected response object.")
            result = .Failure(error)
        }
        return result
    }
    
    func errorWithCode(code: Int, localizeDescription: String) -> NSError {
        return NSError(domain: "ScheduleFetcher", code: code, userInfo: [NSLocalizedDescriptionKey: localizeDescription])
    }
    
    public func courseFromDictionary(courseDict: NSDictionary) -> Course? {
        let title = courseDict["title"] as! String
        let urlString = courseDict["url"] as! String
        let upcomingArray = courseDict["upcoming"] as! [NSDictionary]
        let nextUpcomingDict = upcomingArray.first!
        let nextStartDateString = nextUpcomingDict["start_date"] as! String
        
        let url = NSURL(string: urlString)!
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let nextStartDate = dateFormatter.dateFromString(nextStartDateString)!
        
        return Course(title: title, url: url, nextStartDate: nextStartDate)
    }
    
    func resultFromData(data: NSData) throws -> [Course] {
        let topLevelDict = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
        let courseDicts = topLevelDict["courses"] as! [NSDictionary]
        var courses: [Course] = []
        for courseDict in courseDicts {
            if let course = courseFromDictionary(courseDict) {
                courses.append(course)
            }
        }
        return courses
    }
    
}