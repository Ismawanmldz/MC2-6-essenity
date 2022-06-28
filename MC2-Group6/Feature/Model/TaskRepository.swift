//
//  TaskRepository.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 17/06/22.
//

import UIKit

class TaskRepository {
    
    var coreDataStore : SeederCoreDataStore?
    
    static let shared = TaskRepository(coreDataStore: SeederCoreDataStore())
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    private init(coreDataStore: SeederCoreDataStore) {
        self.coreDataStore = coreDataStore
//        coreDataStore.seedTasks()
        coreDataStore.seedTasks()
        coreDataStore.seedPriotities()
        coreDataStore.seedTags()
    }
    

    
}

