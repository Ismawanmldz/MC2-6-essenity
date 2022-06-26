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
    
}

