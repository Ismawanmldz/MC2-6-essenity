//
//  TestViewController.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 20/06/22.
//

import UIKit

struct Section {
    let title: String
    var options: [SettingsOptionType]
}


enum SettingsOptionType {
    case staticCell(model : SettingsOption)
    case switchCell(model : SettingsSwitchOption)
    case datePickerCell(model: SettingsDatePickerOption)
    case textFieldCell(model: SettingsTextFieldOption)
    case textViewCell(model: SettingsTextFieldOption)
    case tagsCell(model: SettingsTagsOption)
    case buttonCell(model: SettingsButtonOption)
}

struct SettingsButtonOption {
    let title : String
    let icon : UIImage?
    let handler : (()->Void)
}
struct SettingsDatePickerOption {
    let title : String
    let icon : UIImage?
    let handler : (()->Void)
    var date: Date
}

struct SettingsTextFieldOption {
    let title : String
    let handler : (()->Void)
    var cellHeight: Int?
}

struct SettingsSwitchOption {
    let title : String
    let icon : UIImage?
    let handler : (()->Void)
    var isOn: Bool
    var noTag : Int
}

struct SettingsTagsOption {
    let tagTitle : [String]
    let handler : (()->Void)
}


struct SettingsOption {
    let title : String
    let icon : UIImage?
    let handler : (()->Void)
}

class TestViewController: UIViewController {
    
    private var dueDateOn : Bool = true
    private var currentTask : Task?
    
    private var priority : String = "Do Now"
    private var important : Bool = true
    private var urgent : Bool = true
    
    func updatePriorites() {
        switch self.important {
        case true :
            switch self.urgent {
            case true :
                self.priority = "Do Now"
                break
            case false :
                self.priority = "Plan It"
                break
            }
        case false :
            switch self.urgent {
            case true :
                self.priority = "Delegate"
                break
            case false :
                self.priority = "Eliminate"
                break
            }
            
        }
        
    }
    
    @IBAction func donePressed() {
        print("hello")
    }
    
    func updateDueDate() {
//        tableView.reloadData()
//        let allButFirst = (self.tableView.indexPathsForVisibleRows ?? []).filter { $0.section != 0 || $0.row != 0 }
//        self.tableView.reloadRows(at: allButFirst, with: .automatic)

        
//        models[4].options.insert(    .switchCell(model: SettingsSwitchOption(title: "Due Date", icon: UIImage(systemName: "calendar"), handler: {
//            
//        }, isOn: self.dueDateOn, noTag: 41)), at: 0)
            
        self.tableView.reloadSections([4], with: .none)
    }
    
    private let tableView: UITableView  = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(TaskDetailsTableViewCell.self, forCellReuseIdentifier: TaskDetailsTableViewCell.identifier)
        table.register(SwitchTaskDetailsTableViewCell.self, forCellReuseIdentifier: SwitchTaskDetailsTableViewCell.identifier)
        table.register(DatePickerTaskDetailsTableViewCell.self, forCellReuseIdentifier: DatePickerTaskDetailsTableViewCell.identifier)
        table.register(TextFieldTaskDetailsTableViewCell.self, forCellReuseIdentifier: TextFieldTaskDetailsTableViewCell.identifier)
        table.register(DeleteTableViewCell.self, forCellReuseIdentifier: DeleteTableViewCell.identifier)
        table.register(TextViewTaskDetailsTableViewCell.self, forCellReuseIdentifier: TextViewTaskDetailsTableViewCell.identifier)
        table.registerCell(type: TagsTableViewCell.self, identifier: TagsTableViewCell.identifier)
        
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Task Details"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        // Do any additional setup after loading the view.
    }
    
    var models = [Section]()
    
    func configure() {
        models.append(Section(title: "Task Title", options: [
            .textFieldCell(model: SettingsTextFieldOption(title: "Title Text Field" , handler: {
                
            }, cellHeight: 0)),
        ]))
        
        models.append(Section(title: "Description", options: [
            .textViewCell(model: SettingsTextFieldOption(title: "Description" , handler: {
                print("textFiedl works")
            }, cellHeight: 0)),
        
        ]))
        
        models.append(Section(title: "Tags", options: [
            .tagsCell(model: SettingsTagsOption(tagTitle: ["String","Apple","Bed","duck"], handler: {
                
            })),
        ]))
        
        models.append(Section(title: "Set Priority", options: [
            .switchCell(model: SettingsSwitchOption(title: "Urgent", icon: UIImage(systemName: "exclamationmark.triangle"), handler: {
                    
                }, isOn: true, noTag: 31)),
            .switchCell(model: SettingsSwitchOption(title: "Important", icon: UIImage(systemName: "star"), handler: {
                    
            }, isOn: true, noTag: 32)),
            .staticCell(model: SettingsOption(title: "Priority", icon: UIImage(systemName: "folder")) {
                
            }),
        ]))
        
        models.append(Section(title: "", options: [
            .switchCell(model: SettingsSwitchOption(title: "Due Date", icon: UIImage(systemName: "calendar"), handler: {
        
            }, isOn: self.dueDateOn, noTag: 41)),
            .datePickerCell(model: SettingsDatePickerOption(title: "Set Date", icon: UIImage(systemName: "calendar.badge.clock"), handler: {
            
            }, date: Date())),
            .staticCell(model: SettingsOption(title: "Reminder", icon: UIImage(systemName: "bell")) {
                
            }),
            .staticCell(model: SettingsOption(title: "Move to Do Now", icon: UIImage(systemName: "exclamationmark.triangle.fill")) {
                
            }),
        
            

        ]))
        
        
        models.append(Section(title: "", options: [
            .buttonCell(model: SettingsButtonOption(title: "Delete Task", icon: UIImage(systemName: "trash"), handler: {
                
            }))
        
            

        ]))
        
        
    }
    
}

extension TestViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dueDateOn == false {
            if section == 4 {
                return 1
            }
        }
        
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TaskDetailsTableViewCell.identifier,
                for: indexPath
            ) as? TaskDetailsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: model)
            return cell
        case .switchCell(let model) :
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTaskDetailsTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTaskDetailsTableViewCell else {
                return UITableViewCell()
            }
            if indexPath.section == 4 {
                cell.delegate = self
                cell.configure(with: model, dueDateOn: self.dueDateOn)
            } else {
                cell.delegate = self
                cell.configure(with: model)
            }
          
            print("configure cell")
            print(cell.cellSwitch.isOn)
            return cell
        case .datePickerCell(let model) :
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DatePickerTaskDetailsTableViewCell.identifier,
                for: indexPath
            ) as? DatePickerTaskDetailsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: model)
            return cell
        case .textFieldCell(let model) :
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TextFieldTaskDetailsTableViewCell.identifier,
                for: indexPath
            ) as? TextFieldTaskDetailsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: model)
            return cell
        case .tagsCell(let model) :
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TagsTableViewCell.identifier,
                for: indexPath
            ) as? TagsTableViewCell else {
                return UITableViewCell()
            }
//            cell.configure(with: model)
//            cell.configure(with: model)
        
            return cell
        case .textViewCell(let model) :
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TextViewTaskDetailsTableViewCell.identifier,
                for: indexPath
            ) as? TextViewTaskDetailsTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .buttonCell(let model) :
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DeleteTableViewCell.identifier,
                for: indexPath
            ) as? DeleteTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
            
        }
        
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model) :
            model.handler()
        case .datePickerCell(let model) :
            model.handler()
        case .textFieldCell(let model) :
            model.handler()
        case .tagsCell(let model) :
            model.handler()
        case .textViewCell(let model) :
            model.handler()
        case .buttonCell(let model) :
            model.handler()
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        

        if  indexPath.section == 1 {
            return 88
        }
        
        return 44
    }
        
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("heyy")
    }
    
    
    
}

extension TestViewController : SwitchTaskDetailsTableViewCellDelegate {
    func dueDateTapped() {
        let dueDate = self.dueDateOn
        self.dueDateOn = !dueDate
        print("before update ")
        print(self.dueDateOn)
              
        updateDueDate()
        print("after update ")
        print(self.dueDateOn)

    }
    
    func priorityTapped(noTag: Int) {
        if noTag == 32 {
            let important = self.important
            self.important = !important

        } else if noTag == 31 {
            let urgent = self.urgent
            self.urgent = !urgent
        }
        
        updatePriorites()
        print(self.priority)
    }
}
