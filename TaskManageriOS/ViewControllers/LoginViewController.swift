//
//  LoginViewController.swift
//  TaskManageriOS
//
//  Created by Jacob Finn on 10/30/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Set this controller up to be the first view before the user goes on!
    var savedUsername: String? = nil
    var savedPassword: String? = nil
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfPasswordExists()
    }
    
    func checkIfPasswordExists() {
        guard let loadedPassword = DataManager.sharedInstance.loadPassword() else {
         return performSegue(withIdentifier: "create", sender: self)
        }
        savedPassword = loadedPassword
        guard let loadedUsername = DataManager.sharedInstance.loadUsername() else {
            return performSegue(withIdentifier: "create", sender: self)
        }
        savedUsername = loadedUsername
        
    }
    
    @IBAction func createPasswordTapped(_ sender: Any) {
        performSegue(withIdentifier: "create", sender: self)
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        if passwordTextField.text == "" || usernameTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "Username or password has been left blank!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Return", style: .default, handler: { action in
            }))
            self.present(alert, animated: true, completion: nil)
            return
        } else {
            print(savedPassword)
            print(savedUsername)
            if passwordTextField.text == savedPassword && usernameTextField.text == savedUsername {
            login()
            } else {
                let alert = UIAlertController(title: "Error", message: "Invalid username or password!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Return", style: .default, handler: { action in
                }))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
    }
    
    func login() {
        performSegue(withIdentifier: "toTasks", sender: self)
    }
    
        @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }
    
}
