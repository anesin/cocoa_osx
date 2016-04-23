//
//  CourseListViewController.swift
//  RanchForecastSplit
//
//  Created by anesin on 2016. 4. 23..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

protocol CourseListViewControllerDelegate: class {
    
    func courseListViewController(viewController: CourseListViewController, selectedCourse: Course?) -> Void
    
}

class CourseListViewController: NSViewController {
    
    dynamic var courses: [Course] = []
    
    let fetcher = ScheduleFetcher()
    
    @IBOutlet var arrayController: NSArrayController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcher.fetchCoursesUsingCompletionHandler { (result) in
            switch result {
            case .Success(let courses):
                print("Got Courses: \(courses)")
                self.courses = courses
            case .Failure(let error):
                print("Got error: \(error)")
                NSAlert(error: error).runModal()
                self.courses = []
            }
        }
    }
    
    weak var delegate: CourseListViewControllerDelegate? = nil
    
    @IBAction func selectCourse(sender: AnyObject) {
        let selectedCourse = arrayController.selectedObjects.first as! Course?
        delegate?.courseListViewController(self, selectedCourse: selectedCourse)
    }
    
}
