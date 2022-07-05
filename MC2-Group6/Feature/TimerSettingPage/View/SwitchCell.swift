//
//  SwitchCell.swift
//  MC2-Group6
//
//  Created by Elvina Jacia on 27/06/22.
//


import UIKit


class SwitchCell: UITableViewCell {
    static let identifier = "settingCells"
    
        lazy var switchControl: UISwitch = {
            let switchControl = UISwitch()

            if defaultNotifSound == "ON" {
                switchControl.isOn = true
            } else {
                switchControl.isOn = false
            }
            
           
            switchControl.onTintColor = .darkBlue
            switchControl.translatesAutoresizingMaskIntoConstraints = false
            switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
            return switchControl
        }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(switchControl)
        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
 
    @objc func handleSwitchAction(sender: UISwitch){
        if sender.isOn{
            defaultNotifSound = "ON"
            switchControl.isOn = true
            
            //MARK: TAMBAHAN USER DEFAULT
            TimerSettingViewController().defaults.set("ON", forKey: "UDNotifSound")
            
        }else{
            defaultNotifSound = "OFF"
            switchControl.isOn = false
            
            //MARK: TAMBAHAN USER DEFAULT
            TimerSettingViewController().defaults.set("OFF", forKey: "UDNotifSound")
        }
    }
    
    //MARK: TAMBAHAN FUNC USER DEFAULT
    func checkSwitchState(){
        if( TimerSettingViewController().defaults.string(forKey: "UDNotifSound") == "ON"){
            switchControl.setOn(true, animated: false)
        }else{
            switchControl.setOn(false, animated: false)
        }
    }
}


