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
        let imagePicker = UIImagePickerController()
    var dataPassage: DataPassage = .complete
    var selectedTask: Task? = nil
    var selectedTaskIndex: Int? = nil
    let dateFormatter = DateFormatter()
    
    //MARK:- Methods
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
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
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if selectedTask?.image != nil {
            changePictureButton.setTitle("", for: .normal)
        } else {
            changePictureButton.setTitle("Tap me to change picture!", for: .normal)
        }
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
    
    
    @IBAction func changeImageTapped(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        let priority: String
        let taskDate = dateFormatter.string(from: taskDatePicker.date)
        let taskInMain = TaskManager.sharedInstance.getTaskArray().firstIndex(of: selectedTask!)
        switch prioritySegmentedControl.selectedSegmentIndex {
        case 0:
            priority = "normal"
        case 1:
            priority = "high"
        case 2:
            priority = "extreme"
        default:
            priority = "normal"
        }
        switch dataPassage {
            
        case .complete:
            TaskManager.sharedInstance.removeTask(at: taskInMain!)
            let task = Task(title: titleTextField.text!, description: taskDescriptionTextView.text, dueDate: taskDate, image: taskImageView.image, priority: priority, finished: true)
            TaskManager.sharedInstance.addToArrayAt(task: task, index: taskInMain!)
            
            performSegue(withIdentifier: "backToTaskView", sender: self)
        case .incomplete:
            TaskManager.sharedInstance.removeTask(at: taskInMain!)
            let task = Task(title: titleTextField.text!, description: taskDescriptionTextView.text, dueDate: taskDate, image: taskImageView.image, priority: priority, finished: false)
            TaskManager.sharedInstance.addToArrayAt(task: task, index: taskInMain!)
            performSegue(withIdentifier: "backToTaskView", sender: self)
        case .new:
            let task = Task(title: titleTextField.text!, description: taskDescriptionTextView.text, dueDate: taskDate, image: taskImageView.image, priority: priority, finished: false)
            TaskManager.sharedInstance.addToArray(taskToAdd: task)
            performSegue(withIdentifier: "backToTaskView", sender: self)
        }
        
    }
    
    
}

extension CreatorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            taskImageView.contentMode = .scaleAspectFit
            taskImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
