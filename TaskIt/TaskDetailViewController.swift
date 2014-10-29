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
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dateDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(self.detailTaskModel.task)
        self.taskTextField.text = "\(self.detailTaskModel.task)"
        self.descriptionTextField.text = "\(self.detailTaskModel.description)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
