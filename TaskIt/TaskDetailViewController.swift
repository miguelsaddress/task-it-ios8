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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(self.detailTaskModel.task)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
