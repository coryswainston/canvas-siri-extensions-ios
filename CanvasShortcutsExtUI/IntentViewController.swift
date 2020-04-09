//
//  IntentViewController.swift
//  CanvasShortcutsExtUI
//
//  
//  Copyright © 2020 Cory Swainston. All rights reserved.
//

import IntentsUI

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var gradeView: GradeView!
    @IBOutlet weak var assignmentsView: AssignmentsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        
        let data = interaction.intentResponse?.userActivity?.userInfo
        
        switch interaction.intentResponse?.userActivity?.activityType {
        case "coryswainston.CanvasShortcuts.getCourses":
            let courses = data?["courses"] as? [String]
            textView.text = courses?.joined(separator: ", ") ?? "No courses"
        case "coryswainston.CanvasShortcuts.getAssignments":
            displayAssignmentsView(data, interaction.intent as! GetAssignmentsIntent)
        case "coryswainston.CanvasShortcuts.getGrade":
            displayGradeView(data, interaction.intent as! GetGradeIntent)
        default:
            textView.text = "Unexpected intent"
        }
        
        completion(true, parameters, self.desiredSize)
    }
    
    func displayAssignmentsView(_ data : [AnyHashable: Any]?, _ intent: GetAssignmentsIntent) {
        let array = data?["assignments"] as? [Any]

        let assignments = array?.map { (item: Any) -> Assignment in
            return Assignment.fromJson(json: item)
        }
        
//        for subview in self.view.subviews {
//            subview.removeFromSuperview()
//        }
//
//        let tableData = TableData()
//
//        assignmentsView.table.beginUpdates()
//        tableData.assignments.append(contentsOf: assignments!)
//        assignmentsView.table.dataSource = tableData
//        assignmentsView.table.delegate = tableData
//        assignmentsView.table.insertRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0), IndexPath(row: 2, section: 0), IndexPath(row: 3, section: 0)], with: UITableView.RowAnimation.automatic)
//        assignmentsView.table.endUpdates()
//
//        self.view.addSubview(self.assignmentsView)
        
        let assignmentNames = assignments?.map({ (assignment: Assignment) -> String in
            return "\(assignment.name!) - \(assignment.dueDate!)"
        })
        textView.text = assignmentNames?.joined(separator: "\n") ?? "No assignments"
    }
    
    func displayGradeView(_ data : [AnyHashable: Any]?, _ intent: GetGradeIntent) {
        let grade = data?["grade"] as? String ?? "No grade found"
        let score = data?["score"] as? Double
        let course = data?["course"] as? String ?? "No course found"

        var scoreString = "--"
        if let scoreDouble = score {
            scoreString = String(scoreDouble)
        }
        
        for subview in self.view.subviews {
            subview.removeFromSuperview()
        }
        
        self.gradeView.courseLabel.text = course
        self.gradeView.gradeLabel.text = grade
        self.gradeView.scoreLabel.text = "\(scoreString) %"
        
        self.view.addSubview(self.gradeView)
    }
    
    var desiredSize: CGSize {
        let width = self.extensionContext?.hostedViewMaximumAllowedSize.width ?? 300

        return CGSize(width: width, height: 180)
    }
    
}
