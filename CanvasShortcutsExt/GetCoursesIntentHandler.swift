//
//  GetCoursesIntentHandler.swift
//  CanvasShortcuts
//
//
//  Copyright © 2020 Cory Swainston. All rights reserved.
//

import Foundation

class GetCoursesIntentHandler: NSObject, GetCoursesIntentHandling {
    func handle(intent: GetCoursesIntent, completion: @escaping (GetCoursesIntentResponse) -> Void) {
        let activity = NSUserActivity(activityType: "coryswainston.CanvasShortcuts.getCourses")
                    
        getFromCanvas(endpoint: "courses") { (response: Any?, error: CSError?) in
            if let error = error {
                if error == CSError.unauthenticated {
                    return completion(GetCoursesIntentResponse(code: .unauthenticated, userActivity: activity))
                } else {
                    print(error)
                }
            }
            guard let array = response as? [Any] else {
                print(response!)
                return
            }
            let courses = array.map { (item: Any) -> Course in
                return Course.fromJson(json: item)
            }
            let courseNames = courses.map { (course: Course) -> String in
                return course.name
            }
            
            activity.userInfo?["courses"] = courseNames
            
            completion(GetCoursesIntentResponse(code: .success, userActivity: activity))
        }
    }
    
}
