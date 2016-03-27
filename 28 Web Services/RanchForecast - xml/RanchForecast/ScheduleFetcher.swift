//
//  ScheduleFetcher.swift
//  RanchForecast
//
//  Created by anesin on 3/24/16.
//  Copyright © 2016 anesin. All rights reserved.
//

import Foundation

class ScheduleFetcher {
    
    enum FetchCoursesResult {
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
    
    init() {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: config)
    }
    
    func fetchCoursesUsingCompletionHandler(completionHandler: (FetchCoursesResult) -> (Void)) {
        let url = NSURL(string: "http://bookapi.bignerdranch.com/courses.xml")!
        let request = NSURLRequest(URL: url)
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            var result: FetchCoursesResult
            
            if data == nil {
                result = .Failure(error!)
            }
            else if let response = response as? NSHTTPURLResponse {
                print("\(data!.length) bytes, HTTP \(response.statusCode).")
                if response.statusCode == 200 {
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
            NSOperationQueue.mainQueue().addOperationWithBlock({
                completionHandler(result)
            })
        })
        task.resume()
    }
    
    func errorWithCode(code: Int, localizeDescription: String) -> NSError {
        return NSError(domain: "ScheduleFetcher", code: code, userInfo: [NSLocalizedDescriptionKey: localizeDescription])
    }
    
    func courseFromXmlNode(courseNode: NSXMLNode) throws -> Course? {
        let offeringNode = try courseNode.nodesForXPath("offering") as [NSXMLNode]?
        let title = offeringNode!.first!.stringValue!
        
        let hrefNode = try courseNode.nodesForXPath("offering/@href") as [NSXMLNode]?
        let url = NSURL(string: hrefNode!.first!.stringValue!)!

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss z"
        let beginNode = try courseNode.nodesForXPath("begin") as [NSXMLNode]?
        let nextStartDate = dateFormatter.dateFromString(beginNode!.first!.stringValue!)!

        return Course(title: title, url: url, nextStartDate: nextStartDate)
    }
    
    func resultFromData(data: NSData) throws -> [Course] {
        var courses: [Course] = []
        if let doc = try NSXMLDocument(data: data, options: 0) as NSXMLDocument? {
            if let courseNodes = try doc.nodesForXPath("//class") as [NSXMLNode]? {
                for courseNode in courseNodes {
                    if let course = try courseFromXmlNode(courseNode) {
                        courses.append(course)
                    }
                }
            }
        }
        return courses
    }
    
}