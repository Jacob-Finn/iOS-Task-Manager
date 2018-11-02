//
//  DataManager.swift
//  TaskManageriOS
//
//  Created by Jacob Finn on 11/2/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import Foundation

class DataManager {
 static let sharedInstance = DataManager()
    
    
    
    private init () { }
    
     func saveArray(array: [Task]) {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: array)
        UserDefaults.standard.set(savedData, forKey: "taskArray")
    }
     func loadArray() -> [Task]? {
        guard let savedArray = UserDefaults.standard.value(forKey: "taskArray") else {
            print("Failed to load.")
            return nil
        }
        let array = NSKeyedUnarchiver.unarchiveObject(with: savedArray as! Data)
        return array as? [Task]
    }

    
    
}
