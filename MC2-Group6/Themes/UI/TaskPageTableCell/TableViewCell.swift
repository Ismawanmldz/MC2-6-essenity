//
//  TableViewCell.swift
//  MC2-Group6
//
//  Created by Ismawan Maulidza on 6/27/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var delegate : TableViewCellMainDelegate?
    
    private var thisTask : Task?
    
    @IBOutlet weak var TaskName: UILabel!
    @IBOutlet weak var TaskTag: UILabel!
    @IBOutlet weak var TaskDate: UILabel!
    @IBOutlet weak var viewTableCell: UIView!
    @IBOutlet weak var viewBackgroundTable: UIView!
    @IBOutlet weak var checkButton: UIButton!
    
    
    
    var callback : (()->())?
    var indexme = 0
    
    @IBAction func didChecked(_ sender: UIButton) {
        if let currentTask = thisTask {
            let status = !currentTask.status
            thisTask?.status = status
            
            if  thisTask?.status == true {
                self.checkButton.setImage(UIImage(systemName: "circle.fill"), for: .selected)
            }
            else {
                self.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            }
        }
        
        delegate?.reloadAll()
    }
    
    func configure(thisTask : Task) {
        
        
        self.thisTask = thisTask
        TaskName.text = thisTask.title
        //        TaskTag.text = thisTask.tags
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "d MMM"
        
        guard let taskDate = thisTask.dueDate else {return}
        let dateString = dateFormater.string(from: taskDate)
        self.TaskDate.text = dateString
        
        if thisTask.status == true {
            self.checkButton.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        }
        else {
            self.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        
        if thisTask.priorities?.title == "Do Now"{
            self.viewTableCell.backgroundColor = UIColor.red1
        } else if thisTask.priorities?.title == "Plan It"{
            self.viewTableCell.backgroundColor = UIColor.orange2
        } else if thisTask.priorities?.title == "Delegate"{
            self.viewTableCell.backgroundColor = UIColor.blue1
        } else if thisTask.priorities?.title == "Eliminate"{
            self.viewTableCell.backgroundColor = UIColor.green1
        }
        

        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2.5, left: 0, bottom: 2.5, right: 0))
        
        self.contentView.layer.cornerRadius = 5
        //        self.layer.cornerRadius = 10
        //        self.layer.masksToBounds = true
        
        if let currentTask = thisTask {
            if currentTask.status == true {
                self.checkButton.setImage(UIImage(systemName: "circle.fill"), for: .selected)
            }
            else {
                self.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            }
        }
        
        
    }
    
    
    
    override func layoutSubviews() {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
