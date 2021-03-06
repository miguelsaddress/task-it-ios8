//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Miguel Angel Moreno Armenteros on 29/10/14.
//  Copyright (c) 2014 Miguel Angel Moreno Armenteros. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    var detailTaskModel: TaskModel!
    var mainVC: ViewController!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.taskTextField.text = self.detailTaskModel.task
        self.descriptionTextField.text = self.detailTaskModel.description
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
        var task = TaskModel(
            task: self.taskTextField.text,
            description: self.descriptionTextField.text,
            date: self.dueDatePicker.date,
            completed: false
        )
        let indexPath = self.mainVC.tableView.indexPathForSelectedRow()!
        self.mainVC.baseArray[indexPath.section][indexPath.row] = task

        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
