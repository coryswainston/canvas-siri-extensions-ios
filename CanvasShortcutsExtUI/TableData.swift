//
//  AssignmentsTable.swift
//  CanvasShortcuts
//
//  Created by Cory Swainston on 4/8/20.
//  Copyright © 2020 Cory Swainston. All rights reserved.
//

import Foundation
import UIKit

class TableData: NSObject, UITableViewDataSource, UITableViewDelegate {
    var assignments = [Assignment]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(assignments.count)
        return assignments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("made it")
        let cell = tableView.dequeueReusableCell(withIdentifier: "assignment", for: indexPath) as! AssignmentView
                
        print(assignments)
        
        cell.nameLabel.text = assignments[indexPath.row].name
        cell.dueDateLabel.text = assignments[indexPath.row].dueDate.description
        
        return cell
    }
}
