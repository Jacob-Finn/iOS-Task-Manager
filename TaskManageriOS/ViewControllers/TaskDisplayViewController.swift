//
//  TaskDisplayViewController.swift
//  TaskManageriOS
//
//  Created by Jacob Finn on 11/1/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import UIKit

class TaskDisplayViewController: UIViewController, TaskDisplayDelegate {
    
    //MARK:- Types
    enum CurrentView {
        case all
        case incomplete
        case complete
    }
    
    //MARK:- Variables
    var currentView: CurrentView = .all
    var constructedArray: [[Task]] = [[]]
    var cellNumber = 1
    var selectedTask: Task?
    var selectedTaskIndex: Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func reloadView() {
        tableView.reloadData()
    }
    
    func changeView(index: Int) {
        switch index {
        case 0:
            currentView = .all
            constructedArray = [TaskManager.sharedInstance.getTaskArray().filter( {
                $0.priority == .extreme
            }), TaskManager.sharedInstance.getTaskArray().filter( {
                $0.priority == .high
            }), TaskManager.sharedInstance.getTaskArray().filter( {
                $0.priority == .normal
            })]
            tableView.reloadData()
            
            
        case 1:
            print("incomplete")
            currentView = .incomplete
            constructedArray = [TaskManager.sharedInstance.getTaskArray().filter( {
                
                $0.priority == .extreme && $0.finished == false
                
            }), TaskManager.sharedInstance.getTaskArray().filter( {
                
                $0.priority == .high && $0.finished == false
                
                
                
            }), TaskManager.sharedInstance.getTaskArray().filter( {
                
                $0.priority == .normal && $0.finished == false
                
            })]
            tableView.reloadData()
        case 2:
            print("complete")
            currentView = .complete
            constructedArray = [TaskManager.sharedInstance.getTaskArray().filter( {
                $0.priority == .extreme && $0.finished == true
                
                
            }), TaskManager.sharedInstance.getTaskArray().filter( {
                
                $0.priority == .high && $0.finished == true
                
                
            }), TaskManager.sharedInstance.getTaskArray().filter( {
                
                $0.priority == .normal && $0.finished == true
                
            })]
            tableView.reloadData()
        default:
            print("error")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        changeView(index: 0)
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeView(index: 0)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is InfoViewController
        {
            guard let infoViewController = segue.destination as? InfoViewController else {
                print("error")
                return
            }
            switch currentView {
            case .all:
                if selectedTask?.finished == false {
                    infoViewController.dataPassage = .incomplete
                } else {
                    infoViewController.dataPassage = .complete
                }
            case .incomplete:
                 infoViewController.dataPassage = .incomplete
            case .complete:
                 infoViewController.dataPassage = .complete
            }
            infoViewController.selectedTask = selectedTask
            infoViewController.selectedTaskIndex = selectedTaskIndex
        }
    }
    
    
    
}

extension TaskDisplayViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task") as! TaskCell
        cell.setup(task: constructedArray[indexPath.section][indexPath.row])
        if currentView == .all {
            if constructedArray[indexPath.section][indexPath.row].finished == false {
                cell.backgroundColor = UIColor.red
                return cell
            } else {
                cell.backgroundColor = UIColor.green
                return cell
            }
        } else {
             return cell
        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTask = constructedArray[indexPath.section][indexPath.row]
        selectedTaskIndex = TaskManager.sharedInstance.getTaskArray().firstIndex(of: selectedTask!)
        // REMEMBER THIS CODE FOR SELECTION IN A FILTERED ARRAY
        // guard let i = TaskManager.sharedInstance.getTaskArray().firstIndex(of: selectedTask!) else {
        //  print("I cry everytme")
        //    return
        // }
        // print(TaskManager.sharedInstance.getTaskArray()[i].title)
        
        // **********************
        performSegue(withIdentifier: "toInfo", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return constructedArray[0].count
        case 1:
            return constructedArray[1].count
        case 2:
            return constructedArray[2].count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return "Extreme importance"
            }
        case 1:
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return "High Importance"
            }
        case 2:
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return "Normal importance"
            }
        default:
            return nil
        }
        return nil
    }
}
