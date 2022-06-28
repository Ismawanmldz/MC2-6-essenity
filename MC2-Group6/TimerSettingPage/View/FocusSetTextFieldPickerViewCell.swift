//
//  FocusSetTextFieldPickerViewCell.swift
//  MC2-Group6
//
//  Created by Elvina Jacia on 27/06/22.
//

import UIKit

class FocusSetTextFieldPickerViewCell: UITableViewCell {
    
    static let identifier = "focusPickerCell"
    
    let focusDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(focusDonePicker))


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         contentView.addSubview(focusTextField)
        
        focusToolBar.sizeToFit()
        focusTextField.inputAccessoryView = focusToolBar
        focusToolBar.setItems([focusDoneBtn], animated: true)
        focusToolBar.isUserInteractionEnabled = true
        
         focusTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
         focusTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    @objc func focusDonePicker() {

        focusTextField.resignFirstResponder()
        defaultFocusTime = Int(focusSelectedTxt)!*60
    }

}
