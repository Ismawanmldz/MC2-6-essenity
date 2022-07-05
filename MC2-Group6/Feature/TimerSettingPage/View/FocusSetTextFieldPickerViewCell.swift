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
    var selectRow : Int = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(focusTextField)
        let items = [flexibleSpace, focusDoneBtn]
        focusDoneBtn.tintColor = UIColor.darkBlue
        
        focusToolBar.setItems(items, animated: true)
        focusToolBar.sizeToFit()
        focusTextField.inputAccessoryView = focusToolBar
        
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
        
        let row = focusPickerView.selectedRow(inComponent: 0)
        focusPickerView.selectRow(row, inComponent: 0, animated: true)
        
        selectRow = row
        defaults.setValue(selectRow, forKey: fPick)
        
        
    }

}
