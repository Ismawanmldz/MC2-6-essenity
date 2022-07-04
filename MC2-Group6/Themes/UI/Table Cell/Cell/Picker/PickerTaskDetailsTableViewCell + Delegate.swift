//
//  PickerTaskDetailsTableViewCell + Delegate.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 26/06/22.
//

import UIKit

protocol PickerTaskDetailsTableViewCellDelegate{
    func setDate(no : Int, type: Int, text : String)
    func setMoveTo(no : Int, type: Int, text : String)
}
