//
//  TaskOptions.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 26/06/22.
//

import UIKit

struct Section {
    let title: String
    var options: [TaskOptionType]
}


enum TaskOptionType {
    case staticCell(model : TaskOption)
    case switchCell(model : TaskSwitchOption)
    case datePickerCell(model: TaskDatePickerOption)
    case textFieldCell(model: TaskTextFieldOption)
    case textViewCell(model: TaskTextFieldOption)
    case tagsCell(model: TaskTagsOption)
    case buttonCell(model: TaskButtonOption)
    case pickerCell(model: TaskPickerOption)
}

struct TaskButtonOption {
    let title : String
    let icon : UIImage?
    let handler : (()->Void)
}

struct TaskPickerOption {
    let title : String
    let icon : UIImage?
    let handler : (()->Void)
    let option1 : [Int]
    let option2 : [String]
    let noTag : Int?
}

struct TaskDatePickerOption {
    let title : String
    let icon : UIImage?
    let handler : (()->Void)
    var date: Date
}

struct TaskTextFieldOption {
    let title : String
    let handler : (()->Void)
    var cellHeight: Int?
    let noTag : Int?
    let placeholder : String?
}

struct TaskSwitchOption {
    let title : String
    let icon : UIImage?
    let handler : (()->Void)
    var isOn: Bool
    var noTag : Int
}

struct TaskTagsOption {
    let tagTitle : [String]
    let handler : (()->Void)
}


struct TaskOption {
    let title : String
    let icon : UIImage?
    let handler : (()->Void)
}
