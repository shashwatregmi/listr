//
//  ViewController.swift
//  listr
//
//  Created by Regmi on 2020-05-04.
//  Copyright © 2020 Regmi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTaskField: UITextField!
    
    @IBOutlet weak var taskNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTaskField.delegate = self
    }
    // UI Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        taskNameLabel.text = textField.text
    }

    // Event here:
    @IBAction func setDefaultLabel(_ sender: Any) {
        taskNameLabel.text = "Task Name"
    }
}
