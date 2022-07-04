//
//  SettingCellFill.swift
//  MC2-Group6
//
//  Created by Elvina Jacia on 27/06/22.
//

enum SettingCellFillOpt: Int, CaseIterable,CustomStringConvertible{
    case focusTimeOpt
    case shortBreakOpt
    case longBreakOpt
    case longBreakAfterOpt
    case soundOpt
    
    
    var description: String{
        switch self {
            case.focusTimeOpt: return "Focus Time"
            case.shortBreakOpt: return "Short Break"
            case.longBreakOpt: return "Long Break"
            case.longBreakAfterOpt: return "Long Break After"
            case.soundOpt: return "Sound"
        }
    }

}

