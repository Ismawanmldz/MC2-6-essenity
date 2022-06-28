//
//  InitialLoadViewController.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 26/04/22.
//

import UIKit
import CoreData

class InitialLoadViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var users: [User] = [User]()
    
    let taskRepository = TaskRepository.shared
    var initialLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(taskRepository.initialLoad
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        checkIfUserExisted()
    }
    
    func checkIfUserExisted() {
        
        do {
            self.users = try context.fetch(User.fetchRequest())
            if self.users.isEmpty {
                performSegue(withIdentifier: "toOnboarding", sender: self)
            }
            else {
                performSegue(withIdentifier: "toMainPage", sender: self)
            }
        }
        catch {
            print("error")
        }
        
    }
    
    func checkIfInitialLoad() {
        
            self.initialLoad = taskRepository.initialLoad
         
        if taskRepository.initialLoad == false {
                performSegue(withIdentifier: "toOnboarding", sender: self)
            }
            else {
                performSegue(withIdentifier: "toMainPage", sender: self)
            }
 
    }
    

    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    

}
