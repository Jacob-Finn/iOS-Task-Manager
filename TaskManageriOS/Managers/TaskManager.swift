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
    private var completeTasks: [Task] = []
    private var incompleteTasks: [Task] = []
    
    var count: (complete: Int, incomplete: Int) {
        return (completeTasks.count, incompleteTasks.count)
    }
    
    //MARK:- Methods
    
    private init () { }
    
    func addToArray(taskToAdd: Task) {
        incompleteTasks.append(taskToAdd)
    }
    
    
    //MARK:- Getters and setters
    func getCompleteTaskArray() -> [Task] {
        return completeTasks
    }
    
    func getIncompleteTaskArray() -> [Task] {
        return incompleteTasks
    }
    
    func getCompletedTaskAt(index: Int) -> Task {
        return completeTasks[index]
    }
    
    func getIncompleteTaskAt(index: Int) -> Task {
        return incompleteTasks[index]
    }
    
    func removeAt(index: Int, selectedArray: SelectedArray) {
        switch selectedArray {
        case .complete:
            completeTasks.remove(at: index)
        case .incomplete:
            incompleteTasks.remove(at: index)
        }
    }
    
    
    
    func finishTask(index: Int) {
        completeTasks.append(incompleteTasks[index])
        incompleteTasks.remove(at: index)
    }
    func unfinishTask(index: Int) {
        incompleteTasks.append(completeTasks[index])
        completeTasks.remove(at: index)
    }
    
}
