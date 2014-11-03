//
//  TaskModel.swift
//  TaskIt
//
//  Created by Miguel Angel Moreno Armenteros on 31/10/14.
//  Copyright (c) 2014 Miguel Angel Moreno Armenteros. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var task: String
    @NSManaged var subTask: String

}
