//
//  ViewController.swift
//  CanvasShortcuts
//
//  Created by Cory Swainston on 4/6/20.
//  Copyright © 2020 Cory Swainston. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logIn(_ sender: Any) {
        if let link = URL(string: "http://10.0.0.192/login/oauth2/auth?client_id=10000000000001&response_type=code&redirect_uri=canvasshortcuts://auth") {
            UIApplication.shared.open(link)
        }
    }
    
    @IBAction func getCourses(_ sender: Any) {
        getFromCanvas(endpoint: "courses") { (response: Any) in
            guard let array = response as? [Any] else {
                print(response)
                return
            }
            let courses = array.map { (item: Any) -> Course in
                return Course.fromJson(json: item)
            }
            for course in courses {
                print(course.name!)
            }
        }
    }
    
    @IBAction func getAssignments(_ sender: Any) {
        getFromCanvas(endpoint: "assignments", params: ["course_id": "1"]) { (response: Any) in
            guard let array = response as? [Any] else {
                print(response)
                return
            }
            let assignments = array.map { (item: Any) -> Assignment in
                return Assignment.fromJson(json: item)
            }
            for assignment in assignments {
                print(assignment.name!)
            }
        }
    }
}

