//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Miguel Angel Moreno Armenteros on 29/10/14.
//  Copyright (c) 2014 Miguel Angel Moreno Armenteros. All rights reserved.
//

import UIKit
import CoreData

class TaskDetailViewController: UIViewController {

    var detailTaskModel: TaskModel!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.taskTextField.text = self.detailTaskModel.task
        self.descriptionTextField.text = self.detailTaskModel.subTask
        self.dueDatePicker.date = self.detailTaskModel.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        //display the previous VC
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        detailTaskModel.task = self.taskTextField.text
        detailTaskModel.subTask = self.descriptionTextField.text
        detailTaskModel.date = self.dueDatePicker.date
        detailTaskModel.completed = false
        
        appDelegate.saveContext()

        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
