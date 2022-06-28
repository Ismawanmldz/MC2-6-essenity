//
//  DataHelper.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 27/06/22.
//

import CoreData
import Foundation
import UIKit

public class DataHelper {
 
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
             self.context = context
    }
    
    private func seedTags() {
        let newTags = [ "Assignment", "Task", "Exam", "Project"
        ]
        
        
        for noTag in newTags {

            let newTag = Tags(context: self.context)
            newTag.tagTitle = noTag
            
        }
        do {
               try context.save()
            } catch _ {
               }
        
    }
    
    private func seedPriotities() {
        let priorities = [
            (name: "Do Now",count : 0),
            (name: "Plan It" , count : 0),
            (name: "Delegate", count : 0),
            (name: "Eliminate", count : 0),
        ]
        
        for priority in priorities {
//            let newPriority = NSEntityDescription.insertNewObject(forEntityName: "Priority", into: context) as Priority
            let newPriority = Priority(context: self.context)
            newPriority.title = priority.name
            newPriority.count = Int32(priority.count)
        }
        do {
               try context.save()
            } catch _ {
               }
        
    }
    
}
