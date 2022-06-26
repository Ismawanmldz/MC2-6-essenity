//
//  ButtonTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 19/06/22.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonTableView: UIView!
    @IBOutlet weak var buttonButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
