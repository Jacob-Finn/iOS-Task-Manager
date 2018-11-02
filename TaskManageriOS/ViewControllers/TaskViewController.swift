//
//  TaskViewController.swift
//  TaskManageriOS
//
//  Created by Jacob Finn on 10/30/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import UIKit

protocol TaskDisplayDelegate: class {
    
    func changeView(index: Int)
    func reloadView()
}

class TaskViewController: UIViewController {
    
    //MARK:- Types

    
    //MARK:- Variables
    var selectedTask: Task? = nil
    var selectedTaskIndex: Int? = nil
    var constructedArray: [[Task]] = [[]]
    weak var taskDisplayDelegate: TaskDisplayDelegate?
    
    //MARK:- Storyboard
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var taskSegmentedControl: UISegmentedControl!
    
    //MARK:- Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("master loading")
        let task1 = Task(title: "Tester", description: "I am a debug", priority: .extreme)
        TaskManager.sharedInstance.addToArray(taskToAdd: task1)
        let task2 = Task(title: "Incomplete debug", description: "I debug the other array.", priority: .extreme)
        TaskManager.sharedInstance.addToArray(taskToAdd: task2)
        TaskManager.sharedInstance.finishTask(index: 0)
        
        
    }
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
        switch taskSegmentedControl.selectedSegmentIndex {
        case 0:
            taskDisplayDelegate?.changeView(index: 0)
        case 1:
            taskDisplayDelegate?.changeView(index: 1)
        case 2:
            taskDisplayDelegate?.changeView(index: 2)
            
        default:
            print("I am a potato")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        taskSegmentedControl.selectedSegmentIndex = 0
    }
    
        
    @IBAction func unwindToTaskView(segue:UIStoryboardSegue) { }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is TaskDisplayViewController
        {
            guard let taskDisplayViewController = segue.destination as? TaskDisplayViewController else {
                print("error")
                return
            }
            taskDisplayDelegate = taskDisplayViewController
        }
        if segue.destination is CreatorViewController {
            guard let creatorViewController = segue.destination as? CreatorViewController else {
                return
            }
            creatorViewController.dataPassage = .new
        }
    }
    
    
    
}



