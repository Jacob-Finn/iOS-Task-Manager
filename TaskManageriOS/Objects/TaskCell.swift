//
//  TaskCell.swift
//  TaskManageriOS
//
//  Created by Jacob Finn on 10/30/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var statusIndicator: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var taskImageView: UIImageView!
    
    
    // Sets up the tableView cell based on the task that is passed from the indexPath.row
    func setup(task: Task) {
        titleLabel.text = task.title
        descriptionLabel.text = task.taskDescription
        if task.dueDate != "" {
            dueDateLabel.text = task.dueDate
        } else {
            dueDateLabel.text = ""
        }
        if task.finished == false {
            statusIndicator.backgroundColor = UIColor.red
        } else {
            statusIndicator.backgroundColor = UIColor.green
        }
        guard let image = task.image else {
            return
        }
        taskImageView.image = image
    }
    
}
