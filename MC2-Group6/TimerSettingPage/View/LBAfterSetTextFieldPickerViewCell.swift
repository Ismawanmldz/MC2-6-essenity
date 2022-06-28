//
//  LBAfterSetTextFieldPickerViewCell.swift
//  MC2-Group6
//
//  Created by Elvina Jacia on 27/06/22.
//

import UIKit

class LBAfterSetTextFieldPickerViewCell: UITableViewCell {
    
    static let identifier = "longBreakAfterPickerCell"
    
    let longBreakAfterDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(longBreakAfterDonePicker))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(longBreakAfterTextField)
        
        longBreakAfterToolBar.sizeToFit()
        longBreakAfterTextField.inputAccessoryView = longBreakAfterToolBar
        longBreakAfterToolBar.setItems([longBreakAfterDoneBtn], animated: true)
        longBreakAfterToolBar.isUserInteractionEnabled = true
        
        longBreakAfterTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        longBreakAfterTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    @objc func longBreakAfterDonePicker() {
       longBreakAfterTextField.resignFirstResponder()
       defaultLongBreakAfter = Int(longBreakAfterSelectedTxt)!
    }

}

