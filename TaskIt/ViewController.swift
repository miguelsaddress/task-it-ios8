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
    var taskArray:[TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let task1: TaskModel = TaskModel(task: "Comprar chocolate", description: "Uno negro y otro con leche", date: Date.from(year: 2014, month: 10, day: 31))
        let task2: TaskModel = TaskModel(task: "Pasar la ITV", description: "En leganés", date:  Date.from(year: 2014, month: 12, day: 3))
        let task3: TaskModel = TaskModel(task: "Recoger el traje", description: "Ir a recoger el traje a la tintorería de la esquina", date:  Date.from(year: 2014, month: 7, day: 11))
        self.taskArray += [task1, task2, task3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = taskArray[indexPath!.row]
            detailVC.detailTaskModel = thisTask
            detailVC.mainVC = self
        } else if segue.identifier == "showTaskAdd" {
            let addTaskVC: AddTaskViewController = segue.destinationViewController as AddTaskViewController
            addTaskVC.mainVC = self
        }
        
    }

    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        let task = self.taskArray[indexPath.row]
        cell.taskLabel.text = task.task
        cell.descriptionLabel.text = task.description
        cell.dateLabel.text = Date.toStringUsingLocale( task.date )
        return cell
    }

    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        println(indexPath.row)
        self.performSegueWithIdentifier("showTaskDetail", sender: self)
    }



}