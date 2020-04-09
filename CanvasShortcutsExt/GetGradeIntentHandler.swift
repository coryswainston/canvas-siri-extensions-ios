//
//  GetGradeIntentHandler.swift
//  CanvasShortcuts
//
//
//  Copyright © 2020 Cory Swainston. All rights reserved.
//

import Foundation
import Intents

class GetGradeIntentHandler: NSObject, GetGradeIntentHandling {
    func handle(intent: GetGradeIntent,  completion: @escaping (GetGradeIntentResponse) -> Void) {
        let activity = NSUserActivity(activityType: "coryswainston.CanvasShortcuts.getGrade")
        getFromCanvas(endpoint: "courses/grades", params: ["course": intent.course!]) { (response: Any?, error: CSError?) in
            if let error = error {
                print(error)
                if error == CSError.unauthenticated {
                    return completion(GetGradeIntentResponse(code: .unauthenticated, userActivity: activity))
                }
            }
            if let response = response {
                let grade = Grade.fromJson(json: response)
                activity.userInfo?["grade"] = grade.grade
                activity.userInfo?["score"] = grade.score
                activity.userInfo?["course"] = grade.course
            }
            
            completion(GetGradeIntentResponse(code: .success, userActivity: activity))
        }
    }
    
    func resolveCourse(for intent: GetGradeIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        completion(INStringResolutionResult.success(with: intent.course!))
    }
}
