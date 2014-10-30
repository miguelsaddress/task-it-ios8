//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Miguel Angel Moreno Armenteros on 29/10/14.
//  Copyright (c) 2014 Miguel Angel Moreno Armenteros. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var mainVC: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonPressed(sender: UIButton) {
        //here we dont have access to a navigation controller to 
        //pop the current controller
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addTaskPressed(sender: UIButton) {
        let task = self.taskTextField.text
        let description = self.descriptionTextField.text
        let date = self.dueDatePicker.date
        self.mainVC.taskArray.append(TaskModel(task:task, description:description, date:date))
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
