//
//  ViewController.swift
//  TaskIt
//
//  Created by Miguel Angel Moreno Armenteros on 28/10/14.
//  Copyright (c) 2014 Miguel Angel Moreno Armenteros. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //array of fake tasks
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchedResultsController = getFetchedResultsController()
        self.fetchedResultsController.delegate = self
        self.fetchedResultsController.performFetch(nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }

    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = self.fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
            detailVC.detailTaskModel = thisTask
        } else if segue.identifier == "showTaskAdd" {
            let addTaskVC: AddTaskViewController = segue.destinationViewController as AddTaskViewController
        }
    }

    //UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections!.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        let task = self.fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        cell.taskLabel.text = task.task
        cell.descriptionLabel.text = task.subTask
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
        if self.fetchedResultsController.sections![section].numberOfObjects == 0{
            return 0
        } else {
            return 25
        }
    }
        //title of the header
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isAllCompleted() {
            return "COMPLETED"
        } else if section == 0 {
            return "TO DO"
        } else if section == 1 {
            return "COMPLETED"
        } else {
            return nil
        }
    }
    
    //adding this function allows us to have a DELETE feature when swiping the element
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        if indexPath.section == 0 && !isAllCompleted() {
            thisTask.completed = true
        }
        else {
            thisTask.completed = false
        }
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()

    }
    
    //    Renaming the delete button tittle
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String {
        if indexPath.section == 0 && !isAllCompleted() {
            return "Complete"
        } else {
            return "Uncomplete"
        }
    }

//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
//        let thisTask = self.fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
//        
//        var completeAction:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Complete", handler: { (tvra:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
//            thisTask.completed = true
//            (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
//        })
//        completeAction.backgroundColor = UIColor.lightGrayColor()
//
//        var uncompleteAction:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Uncomplete", handler: { (tvra:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
//            thisTask.completed = false
//            (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
//        })
//        uncompleteAction.backgroundColor = UIColor.redColor();
//
//        
//        if indexPath.section == 0 && !isAllCompleted() {
//            return [completeAction]
//        } else {
//            return [uncompleteAction]
//        }
//    }
    
    
    func isAllCompleted() -> Bool {
        var ret:Bool = false
        if self.fetchedResultsController.sections!.count == 1 {
            if self.fetchedResultsController.sections![0].numberOfObjects > 0 {
                var indexPath = NSIndexPath(forItem: 0, inSection: 0)
                var task = self.fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
                ret = task.completed as Bool
            }
        }
        return ret
    }
    

    
    //NSFetchedResultsController delegate
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }

    
    
    //Helpers
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let dateAscending = NSSortDescriptor(key: "date", ascending: true)
        let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        fetchRequest.sortDescriptors = [dateAscending, completedDescriptor]
        return fetchRequest
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        var fetchedResultsController = NSFetchedResultsController(
            fetchRequest: self.taskFetchRequest(),
            managedObjectContext: self.managedObjectContext!,
            sectionNameKeyPath: "completed",
            cacheName: nil
        )
        return fetchedResultsController
    }
    
}