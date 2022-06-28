//
//  TestViewController.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 20/06/22.
//

import UIKit
import CloudKit
import CoreData

class EditTaskViewController: UIViewController {
    
    let taskRepository = TaskRepository.shared
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var dueDateOn : Bool = true
    private var currentTask : Task?

    private var taskTitle : String?
    private var taskDescription : String?
    var taskTags : [String] = []
    private var priority : String = "Do Now"
    var tags : [String] = []
    private var dueDate : Date? = Date()
    private var reminderDate : Date?
    private var moveToDate : Date?
    
    private var important : Bool = true
    private var urgent : Bool = false

    private var reminder : String = "None                                      "
    private var moveTo : String = "None                                    "
    
    private var reminderValue: Int = 0
    private var reminderTimeValue : Int = 0
    
    private var moveToValue: Int = 0
    private var moveToTimeValue : Int = 0
    
    func updatePriorites() {
        switch self.important {
        case true :
            switch self.urgent {
            case true :
                self.priority = "Do Now"
                
            case false :
                self.priority = "Plan It"
                
            }
        case false :
            switch self.urgent {
            case true :
                self.priority = "Delegate"
                
            case false :
                self.priority = "Eliminate"
                
            }
            
        }
        let indexPath = IndexPath(item: 2, section: 3)
        tableView.reloadRows(at: [indexPath], with: .none)
        
    }
    
    @IBAction func doneButton(_ sender: Any) {

        updateTask()
    }
    
//    func add(Task: task) {
//
//    }

    func fetchTask() {
         do {
             let task = try context.fetch(Task.fetchRequest())[0]
             self.currentTask = task
             configureTask(task: self.currentTask!)
             
             DispatchQueue.main.async {
                 self.tableView.reloadData()
             }
         } catch{
             
         }
     }
     
    func configureTask(task : Task){
        self.taskTitle = "Dummy"
        self.taskDescription = "Description"
        self.taskTags = task.tags!
        if(task.dueDate != nil) {
            self.dueDateOn = true
            self.dueDate = task.dueDate
            self.reminderDate = task.reminder
            self.moveToDate = task.moveTo
        }
        else {
            self.dueDateOn = false
        }
        print("DUEDATE")
        print(self.dueDateOn)
        
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "MM-dd-yyyy HH:mm"
        
                
        self.priority = (task.priorities?.title)!

        if priority == "Do Now"{
            self.important = true
            self.urgent = true
        } else if priority == "Plan It"{
            self.urgent = false
            self.important = true
        }else if priority == "Delegate"{
            self.urgent = true
            self.important = false
        }else if priority == "Eliminate"{
            self.urgent = false
            self.important = false
        }
        
        
        setPickerReminder(no: 1, type: 1)
        setPickerMoveTo(no: 2, type: 2)
    }
    
    func setPickerReminder(no: Int, type: Int) {
        self.reminderValue = no
        self.reminderTimeValue = type
        
        if type == 0 {
            self.reminderDate = dueDate
            self.reminder = "None"
        }
        else if type == 1 {
            if let date = Calendar.current.date(byAdding: .minute, value: -1*no, to: dueDate!) {
                self.reminderDate = date
                self.reminder = "\(no)"+" minutes before"
                
            }
        }
        else if type == 2 {
            if let date = Calendar.current.date(byAdding: .hour, value: -1*no, to: dueDate!) {
                self.reminderDate = date
                self.reminder = "\(no)"+" hours before"
            }
        }
        else if type == 3 {
            if let date = Calendar.current.date(byAdding: .day, value: -1*no, to: dueDate!) {
                self.reminderDate = date
                self.reminder = "\(no)"+" days before"
                
            }
        }
    }
    
    func setPickerMoveTo(no: Int, type: Int) {
        self.moveToValue = no
        self.moveToTimeValue = type
        
        if type == 0 {
            self.moveToDate = dueDate
            self.moveTo = "None"
        }
        else if type == 1 {
            if let date = Calendar.current.date(byAdding: .minute, value: -1*no, to: dueDate!) {
                self.moveToDate = date
                self.moveTo = "\(no)"+" minutes before"
                
            }
        }
        else if type == 2 {
            if let date = Calendar.current.date(byAdding: .hour, value: -1*no, to: dueDate!) {
                self.moveToDate = date
                self.moveTo = "\(no)"+" hours before"
            }
        }
        else if type == 3 {
            if let date = Calendar.current.date(byAdding: .day, value: -1*no, to: dueDate!) {
                self.moveToDate = date
                self.moveTo = "\(no)"+" days before"
                
            }
        }
    }
    
    
    func updateTask() {
        let task = Task(context: self.taskRepository.context)
        
        let index = IndexPath(row: 0, section: 0)
        let cell: TextFieldTaskDetailsTableViewCell = tableView.cellForRow(at: index) as! TextFieldTaskDetailsTableViewCell
        let taskTitle = cell.cellTextField.text
        
        let index2 = IndexPath(row: 0, section: 1)
        let cell2: TextViewTaskDetailsTableViewCell = tableView.cellForRow(at: index2) as! TextViewTaskDetailsTableViewCell
        let taskDescription = cell2.cellTextView.text
        
        task.title = taskTitle
        task.tags = self.taskTags
        task.desc = taskDescription
        task.status = false
    
//        var priorityIndex : Int?
//
//        if(self.priority == "Do Now"){
//            priorityIndex = 0
//        } else if(self.priority == "Plan It"){
//            priorityIndex = 1
//        } else if(self.priority == "Delegate"){
//            priorityIndex = 2
//        } else if(self.priority == "Eliminate"){
//            priorityIndex = 3
//        }
        
        do {
            let request = Priority.fetchRequest() as NSFetchRequest<Priority>
            
            let pred = NSPredicate(format: "title == %@", self.priority)
            request.predicate = pred
            
            let priority = try context.fetch(request)
            
            
            task.priorities = priority[0]
        }
        catch {
            
        }
        
        if(dueDateOn == true){
            task.dueDate = self.dueDate
            task.moveTo = self.moveToDate
            task.reminder = self.reminderDate
        }
        
        do {
            try self.taskRepository.context.save()
            print("Saved!")
        }
        catch {
            print("Data not saved")
        }
        print(self.tags)
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
        table.register(PickerTaskDetailsTableViewCell.self, forCellReuseIdentifier: PickerTaskDetailsTableViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTask()
        configure()
        
        title = "Task Details"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
//        navigationController?.navigationBar.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    var models = [Section]()
    
    func calculateTime(timeValue :Date,type: Int, no : Int) -> Date{
        if type == 0 {
            return timeValue
        }
        else if type == 1 {
            if let date = Calendar.current.date(byAdding: .minute, value: -1*no, to: timeValue) {
                return date
//                self.moveToDate = date
            }
        }
        else if type == 2 {
            if let date = Calendar.current.date(byAdding: .hour, value: -1*no, to: timeValue) {
                return date
//                self.moveToDate = date
            }
        }
        else if type == 3 {
            if let date = Calendar.current.date(byAdding: .day, value: -1*no, to: timeValue) {
                return date
//                self.moveToDate = date
            }
        }
        return timeValue
    }
    
    func configure() {
        models.append(Section(title: "Task Title", options: [
            .textFieldCell(model: TaskTextFieldOption(title: "Title Text Field" ,handler: {
                
            }, cellHeight: 0, noTag : 100,placeholder: "Task Title")),
        ]))
        
        models.append(Section(title: "Description", options: [
            .textViewCell(model: TaskTextFieldOption(title: "Description" , handler: {
                
            }, cellHeight: 0, noTag : 101, placeholder: "Description Here")),
        
        ]))
        
        models.append(Section(title: "Tags", options: [
            .tagsCell(model: TaskTagsOption(title: "Tags", tagTitle: [], handler: {
              
            })),
        ]))
        
        models.append(Section(title: "Set Priority", options: [
            .switchCell(model: TaskSwitchOption(title: "Urgent", icon: UIImage(systemName: "exclamationmark.triangle"), handler: {
                    
                }, isOn: true, noTag: 31)),
            .switchCell(model: TaskSwitchOption(title: "Important", icon: UIImage(systemName: "star"), handler: {
                    
            }, isOn: true, noTag: 32)),
            .staticCell(model: TaskOption(title: "Priority", icon: UIImage(systemName: "folder"), handler: {
                
            })),
           
        ]))
        
        models.append(Section(title: "", options: [
            .switchCell(model: TaskSwitchOption(title: "Due Date", icon: UIImage(systemName: "calendar"), handler: {
        
            }, isOn: self.dueDateOn, noTag: 41)),
            .datePickerCell(model: TaskDatePickerOption(title: "Date", icon: UIImage(systemName: "calendar.badge.clock"), handler: {
            
            }, date: Date())),
            .pickerCell(model: TaskPickerOption(title: "Reminder", icon: UIImage(systemName: "bell"), handler: {
                
            }, option1: Array(1...60), option2: ["None","minutes Before","hours Before","days before"], noTag: 51)),
            .pickerCell(model: TaskPickerOption(title: "Move to Do Now", icon: UIImage(systemName: "exclamationmark.triangle.fill"), handler: {
                
            }, option1: Array(1...60), option2: ["None","minutes Before","hours Before","days before"], noTag: 52)),
            

        ]))
        
        
        models.append(Section(title: "", options: [
            .buttonCell(model: TaskButtonOption(title: "Delete Task", icon: UIImage(systemName: "trash"), handler: {

            }))



        ]))
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTagsFromEdit" {
            guard let destination = segue.destination as? EditAddTagsViewController else { return }
            print("this doesnt work")
            print(self.tags)
            destination.taskTags = self.tags
            print(destination.taskTags)
            
        }
    }
    
    @IBAction func unwindTo(segue: UIStoryboardSegue) {
        tableView.reloadData()
        self.tableView.reloadSections([2], with: .none)
        
      }
    
}

extension EditTaskViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dueDateOn == false {
            self.dueDate = nil
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
            cell.configure(with: model, priority: self.priority)
//            cell.cellTitle = self.priority
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
                if indexPath.section == 3 {
                    if indexPath.row == 0 {
                        cell.delegate = self
                        cell.configure(with: model,important : self.urgent)
                    } else {
                        cell.delegate = self
                        cell.configure(with: model,important: self.important)
                    }
                }
          
            }
          
            
            
            return cell
        case .datePickerCell(let model) :
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DatePickerTaskDetailsTableViewCell.identifier,
                for: indexPath
            ) as? DatePickerTaskDetailsTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.configure(with: model,dateDue: self.dueDate!)
            return cell
        case .textFieldCell(let model) :
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TextFieldTaskDetailsTableViewCell.identifier,
                for: indexPath
            ) as? TextFieldTaskDetailsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: model, title : self.taskTitle!)
            return cell
        case .tagsCell(let model) :
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TagsTableViewCell.identifier,
                for: indexPath
            ) as? TagsTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
        
            cell.configure(with: model,tagsArray : self.tags)
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
            cell.configure(with: model, taskDescription: self.taskDescription!)
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
        case .pickerCell(let model) :
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PickerTaskDetailsTableViewCell.identifier,
                for: indexPath
            ) as? PickerTaskDetailsTableViewCell else {
                return UITableViewCell()
            }
            if(model.title == "Reminder") {
                cell.configure(with: model,timeValue: reminder ?? "")
            }
                else {
                cell.configure(with: model,timeValue: moveTo ?? "")
            }
            cell.delegate = self
    
            return cell
            
        }
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let type = models[indexPath.section].options[indexPath.row]
//
//        switch type.self {
//        case .staticCell(let model):
//            model.handler()
//        case .switchCell(let model) :
//            model.handler()
//        case .datePickerCell(let model) :
//            model.handler()
//        case .textFieldCell(let model) :
//            model.handler()
//        case .tagsCell(let model) :
//            model.handler()
//        case .textViewCell(let model) :
//            model.handler()
//        case .buttonCell(let model) :
//            model.handler()
//        case .pickerCell(let model) :
//            print("")
//        }
//
//
//    }
//
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 5 {
            print("delete")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        

        if  indexPath.section == 1 {
            return 88
        }
        
        return 44
    }
        
    
    
    
}

extension EditTaskViewController : SwitchTaskDetailsTableViewCellDelegate {
    func dueDateTapped() {
        let dueDate = self.dueDateOn
        self.dueDateOn = !dueDate

        updateDueDate()
  

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
   
    }
    

}


extension EditTaskViewController : TagsTaskDetailsCollectionViewCellDelegate {
    func addTagPage(tagArray: [String]) {
//        self.tags = tagArray
//        print(tags)
//        self.tableView.reloadSections([2], with: .none)
    }
    
    func addTagPage() {
        
        performSegue(withIdentifier: "toAddTagsFromEdit", sender: self)
    }
}

extension EditTaskViewController : PickerTaskDetailsTableViewCellDelegate {
    func setMoveTo(no: Int, type: Int, text: String) {
        self.moveTo = text
        
        self.moveToValue = no
        self.moveToTimeValue = type
//        let modifiedDate = self.dueDate?.addingTimeInterval(TimeInterval(86400*7 * -1))
//        print(modifiedDate)
        if type == 0 {
            self.moveToDate = dueDate
        }
        else if type == 1 {
            if let date = Calendar.current.date(byAdding: .minute, value: -1*no, to: dueDate!) {
                self.moveToDate = date
            }
        }
        else if type == 2 {
            if let date = Calendar.current.date(byAdding: .hour, value: -1*no, to: dueDate!) {
                self.moveToDate = date
            }
        }
        else if type == 3 {
            if let date = Calendar.current.date(byAdding: .day, value: -1*no, to: dueDate!) {
                self.moveToDate = date
            }
            reloadInputViews()
        }

        
    }
    func setDate(no: Int, type: Int, text: String) {
        self.reminder = text
        self.reminderValue = no
        self.reminderTimeValue = type
        
        if type == 0 {
            self.reminderDate = dueDate
        }
        else if type == 1 {
            if let date = Calendar.current.date(byAdding: .minute, value: -1*no, to: dueDate!) {
                self.reminderDate = date
            }
        }
        else if type == 2 {
            if let date = Calendar.current.date(byAdding: .hour, value: -1*no, to: dueDate!) {
                self.reminderDate = date
            }
        }
        else if type == 3 {
            if let date = Calendar.current.date(byAdding: .day, value: -1*no, to: dueDate!) {
                self.reminderDate = date
                
            }
        }
    
//        let dateFormater = DateFormatter()
//        dateFormater.dateFormat = "MM-dd-yyyy HH:mm"
//        print(dateFormater.string(from: self.reminderDate ?? Date()))
        
        
    }
}

extension EditTaskViewController : DatePickerTaskDetailsTableViewCellDelegate {
    func updateDueDate(date: Date) {
        self.dueDate = date
//        let dateFormater = DateFormatter()
//        dateFormater.dateFormat = "MM-dd-yyyy HH:mm"
//        print(dateFormater.string(from: self.dueDate!))
        
        setDate(no: self.reminderValue, type: self.reminderValue, text: self.reminder)
        setMoveTo(no: self.moveToValue, type: self.moveToTimeValue, text: self.moveTo)
//
//        print(dateFormater.string(from: self.reminderDate!))
//        print(dateFormater.string(from: self.moveToDate!))
//
//
        
    }
}
