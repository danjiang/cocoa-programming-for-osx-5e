//
//  MainWindowController.swift
//  RanchForecast
//
//  Created by 但 江 on 15/10/15.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet var arrayController: NSArrayController!
    @IBOutlet weak var tableView: NSTableView!

    let fetcher = ScheduleFetcher()
    dynamic var courses: [Course] = []
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        tableView.target = self
        tableView.doubleAction = "openClass:"
        
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
    
    func openClass(sender: AnyObject) {
        if let course = arrayController.selectedObjects.first as? Course {
            NSWorkspace.sharedWorkspace().openURL(course.url)
        }
    }
    
}
