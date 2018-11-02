//
//  TaskManager.swift
//  TaskManageriOS
//
//  Created by Jacob Finn on 10/30/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import Foundation

class TaskManager {
    
    //MARK:- Types
    enum SelectedArray {
        case complete
        case incomplete
    }
    
    
    //MARK:- Variables
    static let sharedInstance = TaskManager()
    
    private var selectedArray: SelectedArray? = nil
    private var taskArray: [Task] = []
    
    var count: Int {
        return taskArray.count
    }
    
    
    
    //MARK:- Methods
    
    private init () { }
    
    func addToArray(taskToAdd: Task) {
        print("adding a task")
        taskArray.append(taskToAdd)
    }
    
    
    //MARK:- Getters and setters
    
    
    func getTaskArray() -> [Task] {
        return taskArray
    }
    
    func removeTask(at index: Int) {
        taskArray.remove(at: index)
    }
    
    func finishTask(index: Int) {
        taskArray[index].finished = true
    }
    func unfinishTask(index: Int) {
        taskArray[index].finished = false
    }
    
}
