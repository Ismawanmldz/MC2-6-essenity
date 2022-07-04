//
//  SettingTableViewExtDD.swift
//  MC2-Group6
//
//  Created by Elvina Jacia on 27/06/22.
//

import UIKit

extension TimerSettingViewController: UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingCellFillOpt.allCases.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let option = SettingCellFillOpt(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch option{
        case .focusTimeOpt:
            let cell = tableView.dequeueReusableCell(withIdentifier: FocusSetTextFieldPickerViewCell.identifier, for: indexPath)
            cell.textLabel?.text = SettingCellFillOpt(rawValue: 0)?.description
            cell.selectionStyle = .none
            return cell
        case .shortBreakOpt:
            let cell = tableView.dequeueReusableCell(withIdentifier: SBreakSetTextFieldPickerViewCell.identifier, for: indexPath)
            cell.textLabel?.text = SettingCellFillOpt(rawValue: 1)?.description
            cell.selectionStyle = .none
            return cell
        case .longBreakOpt:
            let cell = tableView.dequeueReusableCell(withIdentifier: LBreakSetTextFieldPickerViewCell.identifier, for: indexPath)
            cell.textLabel?.text = SettingCellFillOpt(rawValue: 2)?.description
            cell.selectionStyle = .none
            return cell
        case .longBreakAfterOpt:
            let cell = tableView.dequeueReusableCell(withIdentifier: LBAfterSetTextFieldPickerViewCell.identifier, for: indexPath)
            cell.textLabel?.text = SettingCellFillOpt(rawValue: 3)?.description
            cell.selectionStyle = .none
            return cell
        case .soundOpt:
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.identifier, for: indexPath)
            cell.textLabel?.text = SettingCellFillOpt(rawValue: 4)?.description
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
            return cell
        }
    }
}


extension TimerSettingViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


