//
//  IntentHandler.swift
//  CanvasShortcutsExt
//
//  
//  Copyright © 2020 Cory Swainston. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        if intent is GetCoursesIntent {
            return GetCoursesIntentHandler()
        }
        if intent is GetAssignmentsIntent {
            return GetAssignmentsIntentHandler()
        }
        if intent is GetGradeIntent {
            return GetGradeIntentHandler()
        }
        return GetCoursesIntentHandler()
    }
}
