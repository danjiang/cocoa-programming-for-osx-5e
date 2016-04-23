//
//  MainSplitViewController.swift
//  RanchForecastSplit
//
//  Created by 但 江 on 15/10/16.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

class MainSplitViewController: NSSplitViewController, CourseListViewControllerDelegate {

    var masterViewController: CourseListViewController {
        let masterItem = splitViewItems[0]
        return masterItem.viewController as! CourseListViewController
    }
    
    var detailViewController: WebViewController {
        let detailItem = splitViewItems[1]
        return detailItem.viewController as! WebViewController
    }
    
    let defaultURL = NSURL(string: "http://www.bignerdranch.com/")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        masterViewController.delegate = self
        detailViewController.loadURL(defaultURL)
    }
    
    // MARK: - CourseListViewControllerDelegate
    
    func courseListViewController(ViewController: CourseListViewController, selectedCourse: Course?) {
        if let course = selectedCourse {
            detailViewController.loadURL(course.url)
        } else {
            detailViewController.loadURL(defaultURL)
        }
    }
    
}
