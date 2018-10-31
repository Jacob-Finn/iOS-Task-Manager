//
//  CreatorViewController.swift
//  TaskManageriOS
//
//  Created by Jacob Finn on 10/30/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import UIKit

class CreatorViewController: UIViewController {
    
    //MARK:- Types
    
    enum DataPassage {
        case complete
        case incomplete
        case new
    }
    
    //MARK:- Storyboard
    
    @IBOutlet weak var changePictureButton: UIButton!
    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    
    //MARK:- Variables
    var dataPassage: DataPassage = .complete
    var selectedTask: Task? = nil
    var selectedTaskIndex: Int? = nil
    let dateFormatter = DateFormatter()
    
    //MARK:- Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDescriptionTextView.layer.borderWidth = 2.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    func setup() {
        if dataPassage != .new {
            guard let selectedTask = selectedTask else {
                return
            }
            titleTextField.text = selectedTask.title
            taskDescriptionTextView.text = selectedTask.taskDescription
            switch selectedTask.priority {
            case .normal:
                prioritySegmentedControl.selectedSegmentIndex = 0
            case .high:
                prioritySegmentedControl.selectedSegmentIndex = 1
            case .extreme:
                prioritySegmentedControl.selectedSegmentIndex = 2
            }
            if selectedTask.dueDate != "" {
                taskDatePicker.date = dateFormatter.date(from: selectedTask.dueDate)!
            }
            if selectedTask.image != nil {
                taskImageView.image = selectedTask.image!
                changePictureButton.isHidden = true
            } else {
                return
            }
        } else {
            return
        }
        
        
    }
    
    
    
    
    
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        
        switch dataPassage {
            
        case .complete:
            performSegue(withIdentifier: "toComplete", sender: self)
        case .incomplete:
            performSegue(withIdentifier: "toIncomplete", sender: self)
        case .new:
            performSegue(withIdentifier: "toIncomplete", sender: self)
        }
        
    }
    
    
}
