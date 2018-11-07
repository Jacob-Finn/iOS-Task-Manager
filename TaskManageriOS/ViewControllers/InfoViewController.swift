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
    // Depending on where we are coming from, dataPassage will change, allowing for me to do different things to
    // elements.
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupView()
    }

    // setupView justs uses the passed variables and sets up the view according to the information that they
    // already contain
    func setupView() {
        print(dataPassage)
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
    
    
    // Finish/Unfinish method
    @IBAction func buttonTapped(_ sender: Any) {
        // ********CHANGE NAME**************
        if let dataPassage = dataPassage {
            print(dataPassage)
            guard let taskInMain = TaskManager.sharedInstance.getTaskArray().firstIndex(of: selectedTask!) else {
                print("Task not found")
                return
            }
            print(dataPassage)
            switch dataPassage {
            case .complete:
                TaskManager.sharedInstance.unfinishTask(index: taskInMain)
                performSegue(withIdentifier: "backToTaskView", sender: self)
            case .incomplete:
                TaskManager.sharedInstance.finishTask(index: taskInMain)
                performSegue(withIdentifier: "backToTaskView", sender: self)
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
            TaskManager.sharedInstance.removeTask(at: selectedTaskIndex)
            performSegue(withIdentifier: "backToTaskView", sender: self)
        case .incomplete:
            TaskManager.sharedInstance.removeTask(at: selectedTaskIndex)
            performSegue(withIdentifier: "backToTaskView", sender: self)
        }
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        performSegue(withIdentifier: "backToTaskView", sender: self)
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
        if segue.destination is TaskDisplayViewController {
            guard let taskDisplayViewController = segue.destination as? TaskDisplayViewController else {
                return
            }
            taskDisplayViewController.reloadView()
        }
    }
    
    
    
    
    
}
