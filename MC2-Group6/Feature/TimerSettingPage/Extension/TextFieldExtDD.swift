//
//  TextFieldExtDD.swift
//  MC2-Group6
//
//  Created by Elvina Jacia on 27/06/22.
//

import UIKit
extension TimerSettingViewController: UITextFieldDelegate{

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == focusTextField{
            focusTextField.inputView = focusPickerView
        } else if textField == shortBreakTextField{
            shortBreakTextField.inputView = shortBreakPickerView
        } else if textField == longBreakTextField{
            longBreakTextField.inputView = longBreakPickerView
        } else if textField == longBreakAfterTextField{
            longBreakAfterTextField.inputView = longBreakAfterPickerView
        }
        return true
    }

}
