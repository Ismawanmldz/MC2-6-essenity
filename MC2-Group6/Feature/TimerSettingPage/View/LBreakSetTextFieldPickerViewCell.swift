//
//  LBreakSetTextFieldPickerViewCell.swift
//  MC2-Group6
//
//  Created by Elvina Jacia on 27/06/22.
//

import UIKit

class LBreakSetTextFieldPickerViewCell: UITableViewCell {
    
    static let identifier = "longBreakPickerCell"
    
    let longBreakDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(longBreakDonePicker))


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         contentView.addSubview(longBreakTextField)
        longBreakTextField.addDoneButtonOnKeyboard()
        
        longBreakToolBar.sizeToFit()
        longBreakTextField.inputAccessoryView = longBreakToolBar
        longBreakToolBar.setItems([longBreakDoneBtn], animated: true)
        longBreakToolBar.isUserInteractionEnabled = true
        
        longBreakTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        longBreakTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    @objc func longBreakDonePicker() {
       longBreakTextField.resignFirstResponder()
       defaultLongBreakTime = Int(longBreakSelectedTxt)!*60
    }
    
}

