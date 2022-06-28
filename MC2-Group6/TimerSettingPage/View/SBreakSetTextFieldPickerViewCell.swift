//
//  SBreakSetTextFieldPickerViewCell.swift
//  MC2-Group6
//
//  Created by Elvina Jacia on 27/06/22.
//

import UIKit

class SBreakSetTextFieldPickerViewCell: UITableViewCell {
    
    static let identifier = "shortBreakPickerCell"
    
    let shortBreakDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(shortBreakDonePicker))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         contentView.addSubview(shortBreakTextField)
        
        shortBreakToolBar.sizeToFit()
        shortBreakTextField.inputAccessoryView = shortBreakToolBar
        shortBreakToolBar.setItems([shortBreakDoneBtn], animated: true)
        shortBreakToolBar.isUserInteractionEnabled = true
        
        shortBreakTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        shortBreakTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    @objc func shortBreakDonePicker() {
        shortBreakTextField.resignFirstResponder()
        defaultShortBreakTime = Int(shortBreakSelectedTxt)!*60
    }

}
