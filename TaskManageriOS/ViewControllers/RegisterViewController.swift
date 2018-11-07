//
//  RegisterViewController.swift
//  TaskManageriOS
//
//  Created by Jacob Finn on 11/5/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    @IBAction func registerTapped(_ sender: Any) {
        if usernameTextField.text == "" || passwordTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "Neither field can be left blank", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Return", style: .default, handler: { action in
            }))
            self.present(alert, animated: true, completion: nil)
            return
        } else {
            register()
        }
    }
    func register() {
        DataManager.sharedInstance.savePassword(password: passwordTextField.text!)
        DataManager.sharedInstance.saveUsername(username: usernameTextField.text!)
        performSegue(withIdentifier: "unWindToLogin", sender: self)
    }
    
}
