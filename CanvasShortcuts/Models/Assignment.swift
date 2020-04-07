//
//  Assignment.swift
//  CanvasShortcuts
//
//  Created by Cory Swainston on 4/6/20.
//  Copyright © 2020 Cory Swainston. All rights reserved.
//

import Foundation

class Assignment: NSObject {
    var desc: String!
    var id: Int!
    var name: String!

    static func fromJson(json: Any) -> Assignment {
        let assignment: Assignment = Assignment()
        
        if let dictionary = json as? [String: Any] {
            assignment.id = dictionary["id"] as? Int
            assignment.name = dictionary["name"] as? String
            assignment.desc = dictionary["description"] as? String

            return assignment
        } else {
            return Assignment()
        }
    }
}
