//
//  TimerSettingViewController.swift
//  MC2-Group6
//
//  Created by Elvina Jacia on 27/06/22.
//


import UIKit


class TimerSettingViewController: UIViewController {
    
    //Outlet
    @IBOutlet weak var backButton: UIButton!
    
    //Variable
    let tableView = UITableView()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view
    
        let back = UIImage(systemName: "chevron.left")
        let backView = UIImageView(image: back)
        backView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissManual))
        backView.addGestureRecognizer(tap)
        let backItem = UIBarButtonItem(customView: backView)
        navigationItem.leftBarButtonItem = backItem
        
        view.addSubview(tableView)
       
    
        tableView.register(FocusSetTextFieldPickerViewCell.self, forCellReuseIdentifier: FocusSetTextFieldPickerViewCell.identifier)
        tableView.register(SBreakSetTextFieldPickerViewCell.self, forCellReuseIdentifier:  SBreakSetTextFieldPickerViewCell.identifier)
        tableView.register(LBreakSetTextFieldPickerViewCell.self, forCellReuseIdentifier:  LBreakSetTextFieldPickerViewCell.identifier)
        tableView.register(LBAfterSetTextFieldPickerViewCell.self, forCellReuseIdentifier:  LBAfterSetTextFieldPickerViewCell.identifier)
        tableView.register(SwitchCell.self, forCellReuseIdentifier: SwitchCell.identifier)
        
        //table view delegate & data source
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 8
        addContraint()
        tableView.isScrollEnabled = false
        tableView.rowHeight = 44
        
        //focus Picker delegate & data source
        focusPickerView.delegate = self
        focusPickerView.dataSource = self
        
        //short break picker delegate & data source
        shortBreakPickerView.delegate = self
        shortBreakPickerView.dataSource = self
        
        //long break picker delegate & data source
        longBreakPickerView.delegate = self
        longBreakPickerView.dataSource = self
        
        //long break after pomodoro intv picker delegate & data source
        longBreakAfterPickerView.delegate = self
        longBreakAfterPickerView.dataSource = self
        
        //text field  delegate & data source
        focusTextField.delegate = self
        shortBreakTextField.delegate = self
        longBreakTextField.delegate = self
        longBreakAfterTextField.delegate = self
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        focusPickerView.selectRow(3, inComponent: 0, animated: true)
        shortBreakPickerView.selectRow(0, inComponent: 0, animated: true)
        longBreakPickerView.selectRow(0, inComponent: 0, animated: true)
        longBreakAfterPickerView.selectRow(0, inComponent: 0, animated: true)
    }
    
    
    @objc func dismissManual() {
        dismiss(animated: true, completion: nil)
    }
    
    func addContraint(){
        var constraints = [NSLayoutConstraint]()

        constraints.append(tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20))
        constraints.append(tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20))
        constraints.append(tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.90 ))
        constraints.append(tableView.heightAnchor.constraint(equalToConstant: 220))
        constraints.append(tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        NSLayoutConstraint.activate(constraints)
    }

}
    

