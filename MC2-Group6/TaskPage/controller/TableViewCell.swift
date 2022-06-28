//
//  TableViewCell.swift
//  MC2-Group6
//
//  Created by Ismawan Maulidza on 6/27/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var TaskName: UILabel!
    @IBOutlet weak var TaskTag: UILabel!
    @IBOutlet weak var TaskDate: UILabel!
    @IBOutlet weak var viewTableCell: UIView!
    @IBOutlet weak var viewBackgroundTable: UIView!
    @IBOutlet weak var checkButton: UIButton!
    
    
    
    var callback : (()->())?
    var indexme = 0
   
    @IBAction func didChecked(_ sender: UIButton) {
        
            callback?()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 5
//        self.layer.cornerRadius = 10
//        self.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
