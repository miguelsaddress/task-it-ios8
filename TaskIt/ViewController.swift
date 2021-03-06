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
    var baseArray: [[TaskModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let task1: TaskModel = TaskModel(task: "Comprar chocolate", description: "Uno negro y otro con leche", date: Date.from(year: 2014, month: 10, day: 31), completed: false)
        let task2: TaskModel = TaskModel(task: "Pasar la ITV", description: "En leganés", date:  Date.from(year: 2014, month: 12, day: 3), completed: false)
        let task3: TaskModel = TaskModel(
                                task: "Recoger el traje",
                                description: "Ir a recoger el traje a la tintorería de la esquina",
                                date:  Date.from(year: 2014, month: 7, day: 11),
                                completed: false
                            )
        let incompletedTaskArray = [task1, task2, task3]
        var completedTaskArray = [TaskModel(task: "completed1", description: "description of completed 1", date: Date.from(year: 2013, month: 9, day: 4), completed:true)]
        self.baseArray = [incompletedTaskArray, completedTaskArray]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.orderTasks()
        self.tableView.reloadData()
    }

    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()!
            let thisTask = self.baseArray[indexPath.section][indexPath.row]
            detailVC.detailTaskModel = thisTask
            detailVC.mainVC = self
        } else if segue.identifier == "showTaskAdd" {
            let addTaskVC: AddTaskViewController = segue.destinationViewController as AddTaskViewController
            addTaskVC.mainVC = self
        }
        
    }

    //UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.baseArray.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.baseArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        let task = self.baseArray[indexPath.section][indexPath.row]
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
        //height of the header
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.baseArray[section].count == 0{
            return 0
        } else {
            return 25
        }
    }
        //title of the header
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
            case 0: return "TO DO"
            case 1: return "COMPLETED"
            default: return nil
        }
    }
    
    //adding this function allows us to have a DELETE feature when swiping the element
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = self.baseArray[indexPath.section][indexPath.row]
        var newTask = TaskModel(task: thisTask.task, description: thisTask.description, date: thisTask.date, completed: !thisTask.completed)
        
        if indexPath.section == 0 {
            self.baseArray[indexPath.section].removeAtIndex(indexPath.row)
            self.baseArray[1].append(newTask)
        } else {
            self.baseArray[indexPath.section].removeAtIndex(indexPath.row)
            self.baseArray[0].append(newTask)
        }
        self.orderTasks()
        self.tableView.reloadData()
    }
    
    //Renaming the delete button tittle
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String {
        if indexPath.section == 0 {
            return "Complete"
        } else {
            return "Uncomplete"
        }
    }

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let thisTask = self.baseArray[indexPath.section][indexPath.row]
        var newTask = TaskModel(task: thisTask.task, description: thisTask.description, date: thisTask.date, completed: !thisTask.completed)

        var completeAction:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Complete", handler: { (tvra:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            self.baseArray[indexPath.section].removeAtIndex(indexPath.row)
            self.baseArray[1].append(newTask)
            self.orderTasks()
            self.tableView.reloadData()
        })
        completeAction.backgroundColor = UIColor.lightGrayColor()

        var uncompleteAction:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Uncomplete", handler: { (tvra:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            self.baseArray[indexPath.section].removeAtIndex(indexPath.row)
            self.baseArray[0].append(newTask)
            self.orderTasks()
            self.tableView.reloadData()
        })
        uncompleteAction.backgroundColor = UIColor.redColor();

        if indexPath.section == 0 {
            return [completeAction]
        } else {
            return [uncompleteAction]
        }
    }
    
    //Helpers
    func orderTasks() {
        for var i=0; i<self.baseArray.count; i++ {
            self.baseArray[i].sort {$0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970}
        }
    }

}