//
//  PickerViewExtDD.swift
//  MC2-Group6
//
//  Created by Elvina Jacia on 27/06/22.
//

import UIKit

extension TimerSettingViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        var component = 0
        if pickerView == focusPickerView{
            component = 2
        } else if pickerView == shortBreakPickerView{
            component = 2
        } else if pickerView == longBreakPickerView{
            component = 2
        } else if pickerView == longBreakAfterPickerView{
            component = 2
        }
        return component
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if pickerView == focusPickerView{
                if component == 0 {
                    return focusTimeListPk.count
                } else {
                    return 1
                }
            } else if pickerView == shortBreakPickerView{
                if component == 0 {
                    return shortBreakListPk.count
                } else{
                    return 1
                }
            } else if pickerView == longBreakPickerView{
                if component == 0 {
                    return longBreakListPk.count
                } else{
                    return 1
                }
            } else if pickerView == longBreakAfterPickerView{
                if component == 0 {
                    return longBreakAfterListPk.count
                } else{
                    return 1
                }
            }
            return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == focusPickerView{
            if component == 0 {
                return focusTimeListPk[row]
            } else {
                return "minutes"
            }
        } else if pickerView == shortBreakPickerView{
            if component == 0 {
                return shortBreakListPk[row]
            } else{
                return "minutes"
            }
        } else if pickerView == longBreakPickerView{
            if component == 0 {
                return longBreakListPk[row]
            } else{
                return "minutes"
            }
        } else if pickerView == longBreakAfterPickerView{
            if component == 0 {
                return longBreakAfterListPk[row]
            } else{
                return "pomodoros"
            }
        }
        return ""
    }

}

extension TimerSettingViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == focusPickerView{
            focusTextField.text = focusTimeListPk[row] + " minutes"
            focusSelectedTxt = focusTimeListPk[row]
        } else if pickerView == shortBreakPickerView{
            shortBreakTextField.text = shortBreakListPk[row] + " minutes"
            shortBreakSelectedTxt = shortBreakListPk[row]
        } else if pickerView == longBreakPickerView{
            longBreakTextField.text = longBreakListPk[row] + " minutes"
            longBreakSelectedTxt = longBreakListPk[row]
        } else if pickerView == longBreakAfterPickerView{
            longBreakAfterTextField.text = longBreakAfterListPk[row] + " pomodoros"
            longBreakAfterSelectedTxt = longBreakAfterListPk[row]
        }
        
        
    }

}


