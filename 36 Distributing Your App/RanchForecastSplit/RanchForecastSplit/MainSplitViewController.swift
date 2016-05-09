//
//  MainSplitViewController.swift
//  RanchForecastSplit
//
//  Created by anesin on 2016. 4. 23..
//  Copyright © 2016년 anesin. All rights reserved.
//

import Cocoa

class MainSplitViewController: NSSplitViewController, CourseListViewControllerDelegate {
    
    var masterViewController: CourseListViewController {
        let masterItem = splitViewItems[0] 
        return masterItem.viewController as! CourseListViewController
    }
    
    var detailViewController: WebViewController {
        let masterItem = splitViewItems[1] 
        return masterItem.viewController as! WebViewController
    }
    
    let defaultURL = NSURL(string: "http://www.bignerdranch.com/")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        masterViewController.delegate = self
        
        detailViewController.loadURL(defaultURL)
    }
    
    // MARK: CourseListViewControllerDelegate
    
    func courseListViewController(viewController: CourseListViewController, selectedCourse: Course?) {
        if let course = selectedCourse {
            detailViewController.loadURL(course.url)
        } else {
            detailViewController.loadURL(defaultURL)
        }
    }
    
}