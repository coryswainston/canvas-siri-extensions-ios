//
//  IntentHandler.swift
//  CanvasShortcutsExt
//
//  Created by Cory Swainston on 4/6/20.
//  Copyright © 2020 Cory Swainston. All rights reserved.
//

import Intents

class IntentHandler: INExtension, GetCoursesIntentHandling {
    
    func handle(intent: GetCoursesIntent, completion: @escaping (GetCoursesIntentResponse) -> Void) {
        completion(GetCoursesIntentResponse.success(course: "Hello world"))
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
