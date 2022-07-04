//
//  SeederCoreData.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 17/06/22.
//

import Foundation
import UIKit

class SeederCoreDataStore {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func seedPriotities() {
        var priorities = [
            (name: "Do Now",count : 0),
            (name: "Plan It" , count : 0),
            (name: "Delegate", count : 0),
            (name: "Eliminate", count : 0),
            (name: "Complete", count : 0),
        ]
        
        for priority in priorities{
//            let newPriority = NSEntityDescription.insertNewObject(forEntityName: "Priority", into: context) as Priority
            let newPriority = Priority(context: self.context)
            newPriority.title = priority.name
            newPriority.count = Int32(priority.count)
        }
        do {
                print("saved")
               try context.save()
            } catch _ {
               }
        
    }

    
    func seedTasks() {
        
//        let tasks = [
//            (title: "Task", tags: ["Assignment"], status: false, priority: "Do Now", dueDate : Date(), desc :"This is a dummy task"),
//             ]
    
        
        let priority1 = Priority(context: self.context)
        priority1.title = "Do Now"
        
        let task1 = Task(context: self.context)
        task1.title = "Dummy Task 21"
        task1.status = false
        task1.desc = "This is a dummy task"
        task1.dueDate = Date()
        task1.tags = ["Assignment"]
        
        do {
            try self.context.save()
            print("Saved!")
        }
        catch {
            print("Data not saved")
        }
        
    }
    
    init() {
        
    }
    
    func seedTags() {
        let newTags = [ "Assignment", "Task", "Exam", "Project"
        ]
        
        
        for noTag in newTags {

            let newTag = Tags(context: self.context)
            newTag.tagTitle = noTag
            
        }
        do {
               try context.save()
            } catch  {
            
               }
        
    }
    
}

