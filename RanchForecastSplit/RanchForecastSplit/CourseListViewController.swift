//
//  CourseListViewController.swift
//  RanchForecastSplit
//
//  Created by 但 江 on 15/10/16.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

protocol CourseListViewControllerDelegate: class {
    func courseListViewController(ViewController: CourseListViewController, selectedCourse: Course?) -> Void
}

class CourseListViewController: NSViewController {

    weak var delegate: CourseListViewControllerDelegate? = nil
    
    dynamic var courses: [Course] = []
    
    let fetcher = ScheduleFetcher()
    
    @IBOutlet var arrayController: NSArrayController!
    
    @IBAction func selectCourse(sender: AnyObject) {
        let selectedCourse = arrayController.selectedObjects.first as! Course?
        delegate?.courseListViewController(self, selectedCourse: selectedCourse)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcher.fetchCoursesUsingCompletionHandler { (result) in
            switch result {
            case .Success(let courses):
                print("Got courses: \(courses)")
                self.courses = courses
            case .Failure(let error):
                print("Got error: \(error)")
                NSAlert(error: error).runModal()
                self.courses = []
            }
        }
    }
    
}
