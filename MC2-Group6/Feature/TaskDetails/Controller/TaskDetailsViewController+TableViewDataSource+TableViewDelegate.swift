//
//  TaskDetailsViewController+TableViewDataSource+TableViewDelegate.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 18/06/22.
//

import UIKit

extension TaskDetailsViewController : UITableViewDataSource {
    
    @objc func switchChanged(_ sender : UISwitch!){
        
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Task Title"
        case 1:
            return "Description"
        case 2:
            return "Tags"
        case 3:
            return "Priority"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1,2:
            return 1
        case 3:
            return 3
        case 4:
            return 4
        case 5:
            return 1
        default :
            return 1
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
            
            
            return cell!
            
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
            
            
            return cell!
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            
            cell?.textLabel?.text = "+ Add Tags"
            
            return cell!
            
            
        case 3:
            
            if(indexPath.row == 0) {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                cell?.textLabel?.text = "Urgent"
                cell?.imageView?.image = UIImage(systemName: "exclamationmark.triangle")
                
                let switchView = UISwitch(frame: .zero)
                switchView.setOn(false, animated: true)
                switchView.tag = indexPath.row // for detect which row switch Changed
                switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
                cell?.accessoryView = switchView
                
                
                return cell!
            } else if (indexPath.row == 1 ){
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                cell?.textLabel?.text = "Important"
                cell?.imageView?.image = UIImage(systemName: "star")
                
                
                let switchView = UISwitch(frame: .zero)
                switchView.setOn(false, animated: true)
                switchView.tag = indexPath.row // for detect which row switch Changed
                switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
                cell?.accessoryView = switchView
                
                
                return cell!
            } else {
                
                let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell3")
                cell.textLabel?.text = "Priority"
                cell.imageView?.image = UIImage(systemName: "folder.fill")
                cell.detailTextLabel?.text = "Do Now"
                
                return cell
            }
            
            
            
        case 4:
            
            if(indexPath.row == 0) {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                cell?.imageView?.image = UIImage(systemName: "calendar")
                cell?.textLabel?.text = "Due Date"
                
                let switchView = UISwitch(frame: .zero)
                switchView.setOn(false, animated: true)
                switchView.tag = indexPath.row // for detect which row switch Changed
                switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
                cell?.accessoryView = switchView
                
                
                return cell!
                
              
            } else if (indexPath.row == 1 ){
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                
                cell?.textLabel?.text = "Set Date"
                cell?.imageView?.image = UIImage(systemName: "calendar.badge.clock")
                
                let dateView = UIDatePicker(frame: .zero)
                dateView.datePickerMode = UIDatePicker.Mode.date
                dateView.minimumDate = Date()
                dateView.tag = indexPath.row // for detect which row switch Changed
                cell?.accessoryView = dateView
                
                
                return cell!
                
            } else if (indexPath.row == 2){
                
                let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell3")
                cell.textLabel?.text = "Reminder"
                cell.detailTextLabel?.text = "1 Day Before"
                cell.imageView?.image = UIImage(systemName: "bell")
                return cell
            } else if (indexPath.row == 3){
                
                let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell3")
                cell.textLabel?.text = "Move to Do Now"
                cell.detailTextLabel?.text = "1 Minutes Before"
                cell.imageView?.image = UIImage(systemName: "exclamationmark.triangle.fill")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                
                let switchView = UISwitch(frame: .zero)
                switchView.setOn(false, animated: true)
                switchView.tag = indexPath.row // for detect which row switch Changed
                switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
                cell?.accessoryView = switchView
                
                
                return cell!
            }
        
            
        case 5:
            
            let cell = taskDetailsView.tableView.dequeueReusableCell(
                withIdentifier: "blueCell", for: indexPath) as! BlueTableViewCell
            return cell
            
            
      
            
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            
            let switchView = UISwitch(frame: .zero)
            switchView.setOn(false, animated: true)
            switchView.tag = indexPath.row // for detect which row switch Changed
            switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            cell?.accessoryView = switchView
            
            
            return cell!
            
        
        }

}


}

extension TaskDetailsViewController: UITableViewDelegate {
    
}

