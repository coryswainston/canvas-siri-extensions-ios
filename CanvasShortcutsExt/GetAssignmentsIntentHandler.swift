//
//  GetAssignmentsIntentHandler.swift
//  CanvasShortcuts
//
//  
//  Copyright © 2020 Cory Swainston. All rights reserved.
//

import Foundation
import Intents

class GetAssignmentsIntentHandler: NSObject, GetAssignmentsIntentHandling {
    
    func handle(intent: GetAssignmentsIntent, completion: @escaping (GetAssignmentsIntentResponse) -> Void) {
        let activity = NSUserActivity(activityType: "coryswainston.CanvasShortcuts.getAssignments")
        
        var dateRange: String!
        switch (intent.dateRange) {
        case DateRange.today:
            dateRange = "today"
        default:
            dateRange = "thisWeek"
        }
    
        getFromCanvas(endpoint: "assignments", params: ["course_id": "1", "date_range": dateRange]) { (response: Any?, error: CSError?) in
            if let error = error {
                print(error)
                if (error == CSError.unauthenticated) {
                    return completion(GetAssignmentsIntentResponse(code: .unauthenticated, userActivity: activity))
                }
            }
            
            guard let array = response as? [Any] else {
                print(response!)
                return
            }
            
            activity.userInfo?["assignments"] = array
            
            completion(GetAssignmentsIntentResponse(code: .success, userActivity: activity))
        }

    }
        
    func resolveDateRange(for intent: GetAssignmentsIntent, with completion: @escaping (DateRangeResolutionResult) -> Void) {
        completion(DateRangeResolutionResult.success(with: intent.dateRange))
    }
}
