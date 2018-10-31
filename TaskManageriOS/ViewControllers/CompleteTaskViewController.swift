//
//  IncompleteTaskViewController.swift
//  TaskManageriOS
//
//  Created by Jacob Finn on 10/30/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import UIKit

class CompleteTaskViewController: UIViewController {
    
    //MARK:- Variables
    var selectedTask: Task? = nil
    var selectedTaskIndex: Int? = nil
    var constructedArray: [[Task]] = [[]]
    
    //MARK:- Storyboard
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        constructedArray = [TaskManager.sharedInstance.getCompleteTaskArray().filter( { $0.priority == .extreme }), TaskManager.sharedInstance.getCompleteTaskArray().filter( { $0.priority == .high }), TaskManager.sharedInstance.getCompleteTaskArray().filter( { $0.priority == .normal })]
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
            infoViewController.dataPassage = .complete
            infoViewController.selectedTask = selectedTask
            infoViewController.selectedTaskIndex = selectedTaskIndex
        }
        if segue.destination is CreatorViewController {
            guard let creatorViewController = segue.destination as? CreatorViewController else {
                return
            }
            creatorViewController.dataPassage = .complete
        }
    }
    @IBAction func unwindToComplete(segue:UIStoryboardSegue) { }
}

//MARK:- TableView

extension CompleteTaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task") as! TaskCell
        cell.setup(task: constructedArray[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTask = TaskManager.sharedInstance.getCompletedTaskAt(index: indexPath.row)
        selectedTaskIndex = indexPath.row
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
