//
//  TaskTableViewCell.swift
//  MC2-Group6
//
//  Created by Hana Salsabila on 27/06/22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskPriority: UIView!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskTags: UILabel!
    @IBOutlet weak var taskDueDate: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var taskView: UIView!
    
    var callback : (()->())?
    var indexme = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didChecked(_ sender: UIButton) {
        // use the tag of button as index
        callback?()
    }
    
}
