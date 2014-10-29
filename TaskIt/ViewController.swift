//
//  ViewController.swift
//  TaskIt
//
//  Created by Miguel Angel Moreno Armenteros on 28/10/14.
//  Copyright (c) 2014 Miguel Angel Moreno Armenteros. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //array of fake tasks
    //let taskArray:[[String:String]] = []
    var taskArray:[Dictionary<String,String>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let task1: Dictionary<String,String> = ["task": "Comprar chocolate", "description": "Uno negro y otro con leche", "date": "31/10/2014"]
        let task2: Dictionary<String,String> = ["task": "Pasar la ITV", "description": "En leganés", "date": "03/12/2014"]
        let task3: Dictionary<String,String> = ["task": "Recoger el traje", "description": "Ir a recoger el traje a la tintorería de la esquina", "date": "07/11/2014"]
        self.taskArray += [task1, task2, task3]
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        let task = self.taskArray[indexPath.row]
        cell.taskLabel.text = task["task"]
        cell.descriptionLabel.text = task["description"]
        cell.dateLabel.text = task["date"]
        return cell
    }

    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
    }


}