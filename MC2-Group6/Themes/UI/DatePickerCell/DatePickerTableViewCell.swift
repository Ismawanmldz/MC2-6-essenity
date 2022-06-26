//
//  DatePickerTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 18/06/22.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIDatePicker!
    
    @IBOutlet weak var cellDatePicker: UIDatePicker!
    @IBOutlet weak var cellTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
