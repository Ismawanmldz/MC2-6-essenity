//
//  PickerViewValue.swift
//  MC2-Group6
//
//  Created by Elvina Jacia on 27/06/22.
//

import UIKit

let pickerView = UIPickerView()

let focusPickerView = UIPickerView()
let focusToolBar = UIToolbar()
let focusTimeListPk = ["5", "10",  "20",  "25",  "30",  "35",  "40",  "45",  "50",  "55",  "60"]

let shortBreakPickerView = UIPickerView()
let shortBreakToolBar = UIToolbar()
let shortBreakListPk = ["1", "2",  "3",  "4",  "5",  "6",  "7",  "8",  "9", "10"]

let longBreakPickerView = UIPickerView()
let longBreakToolBar = UIToolbar()
let longBreakListPk = ["20", "25",  "30",  "35",  "40",  "45",  "50",  "55",  "60"]

let longBreakAfterPickerView = UIPickerView()
let longBreakAfterToolBar = UIToolbar()
let longBreakAfterListPk = ["2", "3", "4"]


//MARK: DEFAULT CALCULATION VALUE:
var focusTimeCalc: Int = defaultFocusTime / 60 % 60
var focusSelectedTxt = "\(focusTimeCalc)"

let focusTextField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.text = focusSelectedTxt + " minutes"
    tf.textColor = .gray
    return tf
}()

var shortBreakTimeCalc: Int = defaultShortBreakTime / 60 % 60
var shortBreakSelectedTxt = "\(shortBreakTimeCalc)"

let shortBreakTextField: UITextField = {
    let tfs = UITextField()
    tfs.translatesAutoresizingMaskIntoConstraints = false
    tfs.text = shortBreakSelectedTxt + " minutes"
    tfs.textColor = .gray
    return tfs
}()

var longBreakTimeCalc: Int = defaultLongBreakTime / 60 % 60
var longBreakSelectedTxt = "\(longBreakTimeCalc)"

let longBreakTextField: UITextField = {
    let tfd = UITextField()
    tfd.translatesAutoresizingMaskIntoConstraints = false
    tfd.text = longBreakSelectedTxt + " minutes"
    tfd.textColor = .gray
    return tfd
}()

var longBreakAfterCalc: Int = defaultLongBreakAfter
var longBreakAfterSelectedTxt = "\(longBreakAfterCalc)"

let longBreakAfterTextField: UITextField = {
    let tfp = UITextField()
    tfp.translatesAutoresizingMaskIntoConstraints = false
    tfp.text = longBreakAfterSelectedTxt + " pomodoros"
    tfp.textColor = .gray
    return tfp
}()

//let x

let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
