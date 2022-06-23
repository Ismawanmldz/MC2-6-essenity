//
//  TaskDetailsView.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 18/06/22.
//

import UIKit

class TaskDetailsView: UIView {

    @IBOutlet weak var tableView: UITableView!

    weak var delegate : TaskDetailsViewDelegate?
    
    func setup(delegate : TaskDetailsViewDelegate){
        
        self.delegate = delegate
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.registerCell(type: PickerTableViewCell.self, identifier: "pickerCell")
        tableView.registerCell(type: SwitchTableViewCell.self, identifier: "switchCell")
        tableView.registerCell(type: DatePickerTableViewCell.self, identifier: "datePickerCell")
        tableView.registerCell(type: ButtonTableViewCell.self, identifier: "buttonCell")
    }
    
    
}
