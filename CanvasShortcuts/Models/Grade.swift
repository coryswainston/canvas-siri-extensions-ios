//
//  Grade.swift
//  CanvasShortcuts
//
//  Created by Cory Swainston on 4/8/20.
//  Copyright © 2020 Cory Swainston. All rights reserved.
//

import Foundation

class Grade: NSObject {
    var grade: String!
    var score: Double!
    var course: String!
    
    static func fromJson(json: Any) -> Grade {
        let grade: Grade = Grade()
        
        if let dictionary = json as? [String: Any] {
            grade.grade = dictionary["grade"] as? String
            grade.score = dictionary["score"] as? Double
            grade.course = dictionary["course"] as? String
            
            return grade
        } else {
            return Grade()
        }
    }
}
