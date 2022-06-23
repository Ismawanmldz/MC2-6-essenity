//
//  TaskDetailsViewController.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 18/06/22.
//

import UIKit

class TaskDetailsViewController: UIViewController {

    @IBOutlet var taskDetailsView: TaskDetailsView!

    let taskRepository = TaskRepository.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDetailsView.tableView.registerCell(type: BlueTableViewCell.self, identifier: "blueCell")
    
        taskDetailsView.setup(delegate: self)
        taskDetailsView.tableView.dataSource = self
        taskDetailsView.tableView.delegate = self
        
    }
    
}
