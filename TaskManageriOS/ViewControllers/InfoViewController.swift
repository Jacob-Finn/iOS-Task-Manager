//
//  InfoViewController.swift
//  TaskManageriOS
//
//  Created by Jacob Finn on 10/30/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    //MARK:- Types
    // Depending on where we are coming from, dataPassage will change, so I know if I'm dealing with the
    // complete task array or the incomplete task array.
    enum DataPassage {
        case complete
        case incomplete
    }
    
    //MARK:- Storyboard
    
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK:- Variables
    var dataPassage: DataPassage? = nil
    var selectedTask: Task? = nil
    var selectedTaskIndex: Int? = nil
    
    //MARK:- Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    func setupView() {
        if let dataPassage = dataPassage {
            switch dataPassage {
            case .complete:
                statusButton.setTitle("Unfinish", for: .normal)
            case .incomplete:
                statusButton.setTitle("Finish", for: .normal)
            }
        }
        else {
            print("Data passage wasn't defined! This will cause an error later on!")
        }
        guard let selectedTask = selectedTask else {
            print("Error. No task defined.")
            return
        }
        guard let selectedTaskIndex = selectedTaskIndex else {
            print("Task index wasn't defined! This will cause an error later on!")
            return
        }
        titleLabel.text = selectedTask.title
        descriptionTextView.text = selectedTask.taskDescription
        dueDateLabel.text = selectedTask.dueDate
        if selectedTask.image != nil {
            taskImageView.image = selectedTask.image
        }
        
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        if let dataPassage = dataPassage {
            print(dataPassage)
            switch dataPassage {
            case .complete:
                TaskManager.sharedInstance.unfinishTask(index: selectedTaskIndex!)
                dismiss(animated: true)
            case .incomplete:
                TaskManager.sharedInstance.finishTask(index: selectedTaskIndex!)
                dismiss(animated: true)
            }
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let dataPassage = dataPassage else {
            return
        }
        guard let selectedTaskIndex = selectedTaskIndex else {
            return
        }
        switch dataPassage {
        case .complete:
            TaskManager.sharedInstance.removeAt(index: selectedTaskIndex, selectedArray: .complete)
            dismiss(animated: true)
        case .incomplete:
            TaskManager.sharedInstance.removeAt(index: selectedTaskIndex, selectedArray: .incomplete)
            dismiss(animated: true)
        }
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is CreatorViewController
        {
            guard let creatorViewController = segue.destination as? CreatorViewController else {
                print("error")
                return
            }
            guard let dataPassage = self.dataPassage else {
                return
            }
            switch dataPassage {
            case .complete:
                creatorViewController.dataPassage = .complete
                creatorViewController.selectedTask = self.selectedTask
                creatorViewController.selectedTaskIndex = self.selectedTaskIndex
            case .incomplete:
                creatorViewController.dataPassage = .incomplete
                creatorViewController.selectedTaskIndex = self.selectedTaskIndex
                creatorViewController.selectedTask = self.selectedTask
            }
        }
    }
    
    
    
    
    
}
