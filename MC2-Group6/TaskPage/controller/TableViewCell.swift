//
//  TableViewCell.swift
//  MC2-Group6
//
//  Created by Ismawan Maulidza on 6/27/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    var delegate : TableViewCellMainDelegate?
    
    
    @IBOutlet weak var TaskName: UILabel!
    @IBOutlet weak var TaskTag: UILabel!
    @IBOutlet weak var TaskDate: UILabel!
    @IBOutlet weak var viewTableCell: UIView!
    @IBOutlet weak var viewBackgroundTable: UIView!
    @IBOutlet weak var checkButton: UIButton!
    
    
    
    var callback : (()->())?
    var indexme = 0
   
    @IBAction func didChecked(_ sender: UIButton) {
        delegate?.reloadAll()
        callback?()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2.5, left: 0, bottom: 2.5, right: 0))

        self.contentView.layer.cornerRadius = 5
//        self.layer.cornerRadius = 10
//        self.layer.masksToBounds = true
    }

    override func layoutSubviews() {
      
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
