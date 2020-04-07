//
//  Course.swift
//  CanvasShortcuts
//
//  Created by Cory Swainston on 4/6/20.
//  Copyright © 2020 Cory Swainston. All rights reserved.
//

import Foundation

class Course: NSObject {
    var startDate: Date!
    var endDate: Date!
    var id: Int!
    var name: String!
    
    static func fromJson(json: Any) -> Course {
        let course: Course = Course()
        
        if let dictionary = json as? [String: Any] {
            course.startDate = ISO8601DateFormatter().date(from: dictionary["start_date"] as! String)
            course.endDate = ISO8601DateFormatter().date(from: dictionary["end_date"] as! String)
            course.id = dictionary["id"] as? Int
            course.name = dictionary["name"] as? String
            
            return course
        } else {
            return Course()
        }
    }
}
