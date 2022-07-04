////
////  TestViewController.swift
////  MC2-Group6
////
////  Created by Jonathan Andryana on 20/06/22.
////
//
//import UIKit
//import CloudKit
//import CoreData
//import UserNotifications
//
//class TaskDetailsViewController: UIViewController {
//
//    var delegate : AddTaskViewControllerDelegate?
//
//    let taskRepository = TaskRepository.shared
//
//    private var Task : Task?
//    private var isEdit : Bool?
//    var taskTags : [String]?
//
//    var tagsContainer : [Tags]?
//
//    private var dueDateOn : Bool = true
//    private var currentTask : Task?
//
//
//
//    private var priority : String = "Do Now"
//    private var important : Bool = true
//    private var urgent : Bool = true
//    var tags : [String] = []
//    private var taskDescription : String?
//    private var taskTitle : String?
//    private var dueDate : Date? = Date()
//    private var reminder : String = "None                                      "
//    private var moveTo : String = "None                                    "
//    private var reminderDate : Date?
//    private var moveToDate : Date?
//    var taskTags : [String] = []
//
//    private var reminderValue: Int = 0
//    private var reminderTimeValue : Int = 0
//
//    private var moveToValue: Int = 0
//    private var moveToTimeValue : Int = 0
//
//    func updatePriorites() {
//        switch self.important {
//        case true :
//            switch self.urgent {
//            case true :
//                self.priority = "Do Now"
//
//            case false :
//                self.priority = "Plan It"
//
//            }
//        case false :
//            switch self.urgent {
//            case true :
//                self.priority = "Delegate"
//
//            case false :
//                self.priority = "Eliminate"
//
//            }
//
//        }
//        let indexPath = IndexPath(item: 2, section: 3)
//        tableView.reloadRows(at: [indexPath], with: .none)
//
//    }
//
//    @IBAction func backButtonPressed(_ sender: UIButton) {
//
//        let index = IndexPath(row: 0, section: 0)
//        let cell: TextFieldTaskDetailsTableViewCell = tableView.cellForRow(at: index) as! TextFieldTaskDetailsTableViewCell
//        let taskTitle = cell.cellTextField.text
//
//        let index2 = IndexPath(row: 0, section: 1)
//        let cell2: TextViewTaskDetailsTableViewCell = tableView.cellForRow(at: index2) as! TextViewTaskDetailsTableViewCell
//        let taskDescription = cell2.cellTextView.text
//
//        if (taskTitle != "" || taskDescription != "") {
//            let alert = UIAlertController(title: "Delete ", message: "Are you sure you want to to back. All progress will be lost!", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
//                self.dismiss(animated: true)
//            }))
//            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        } else {
//            self.dismiss(animated: true)
//        }
//
//    }
//
//
//    @IBAction func doneButton(_ sender: Any) {
//
////        let timer = Timer(fireAt: Date(), interval: 5, target: <#T##Any#>, selector: <#T##Selector#>, userInfo: <#T##Any?#>, repeats: <#T##Bool#>)
//
//        let index = IndexPath(row: 0, section: 0)
//        let cell: TextFieldTaskDetailsTableViewCell = tableView.cellForRow(at: index) as! TextFieldTaskDetailsTableViewCell
//        let taskTitle = cell.cellTextField.text
//
//
//
//        if (taskTitle == "" || ((taskTitle?.isEmpty) == true)){
//            let alert = UIAlertController(title: "Add Title ", message: "The Task needs a title", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        } else {
//            updateTask()
//            scheduleReminder()
//
//            self.dismiss(animated: true)
//
//    }
//}
//
//    @IBAction func cancelButton(_ sender: Any){
//        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["id"])
//    }
//
//
//    func setReminder(){
//        let content = UNMutableNotificationContent()
//        content.title = "You have unfinished tasks"
//        content.sound = .default
//        content.body = "Your task \(self.taskTitle) is due to be finished "
//
//        guard let targetDate = self.reminderDate else { return }
//        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
//        let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
//            if error != nil {
//                print("error occured")
//            }
//            print("set reminder")
//
//        })
//    }
//
//
//    func scheduleReminder(){
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {success, error in
//            if success {
//                print("successSetReminder")
//                self.setReminder()
//            }else if let error = error {
//                print("occured")
//            }
//        })
//    }
//
//    func updateTask() {
//        let task = Task(context: self.taskRepository.context)
//        let index = IndexPath(row: 0, section: 0)
//        let cell: TextFieldTaskDetailsTableViewCell = tableView.cellForRow(at: index) as! TextFieldTaskDetailsTableViewCell
//        let taskTitle = cell.cellTextField.text
//
//        let index2 = IndexPath(row: 0, section: 1)
//        let cell2: TextViewTaskDetailsTableViewCell = tableView.cellForRow(at: index2) as! TextViewTaskDetailsTableViewCell
//        let taskDescription = cell2.cellTextView.text
//
//        task.title = taskTitle
//        task.tags = []
//        task.tags? = self.tags
//        task.desc = taskDescription
//        task.status = false
//
//
////        for tag in self.tagsContainer {
////            let request = Priority.fetchRequest() as NSFetchRequest<Priority>
////
////            let pred = NSPredicate(format: "title == %@", noTags.tagti)
////            request.predicate = pred
////
////            let priority = try context.fetch(request)
////
////
////            task.priorities = priority[0]
////        }
//
////
////        if let tagsHere = self.tagsContainer {
////            for noTags in tagsHere {
////                task.setValue(noTags, forKey: "tags")
////            }
////        }
//
////        var priorityIndex : Int?
////
////        if(self.priority == "Do Now"){
////            priorityIndex = 0
////        } else if(self.priority == "Plan It"){
////            priorityIndex = 1
////        } else if(self.priority == "Delegate"){
////            priorityIndex = 2
////        } else if(self.priority == "Eliminate"){
////            priorityIndex = 3
////        }
//
//        do {
//            let request = Priority.fetchRequest() as NSFetchRequest<Priority>
//
//            let pred = NSPredicate(format: "title == %@", self.priority)
//            request.predicate = pred
//
//            let priority = try taskRepository.context.fetch(request)
//
//
//            task.priorities = priority[0]
//        }
//        catch {
//
//        }
//
//        if(dueDateOn == true){
//            task.dueDate = self.dueDate
//            task.moveTo = self.moveToDate
//            task.reminder = self.reminderDate
//            task.reminderValue = Int16(self.reminderValue)
//            task.reminderTimeValue = Int16(self.reminderTimeValue)
//            task.moveToValue = Int16(self.moveToValue)
//            task.moveToTimeValue = Int16(self.moveToTimeValue)
//
//            let dateFormater = DateFormatter()
////            dateFormater.dateFormat = "MM-dd-yyyy HH:mm"
////    print("dueDate")
////    print(dateFormater.string(from: self.dueDate!))
//        } else {
//            task.dueDate = nil
//            task.moveTo = nil
//            task.reminder = nil
//        }
//
////        if let tagsContain = self.tagsContainer,
////           let noTags = tagsContain as? [Tags]
////        {
////            for tag in noTags {
////
////            }
////        }
//
//        do {
//            try self.taskRepository.context.save()
//            print("Saved!")
//        }
//        catch {
//            print("Data not saved")
//        }
//        print(task.tags)
//    }
//
//    func updateDueDate() {
//        self.tableView.reloadSections([4], with: .none)
//    }
//
//    private let tableView: UITableView  = {
//        let table = UITableView(frame: .zero, style: .insetGrouped)
//        table.register(TaskDetailsTableViewCell.self, forCellReuseIdentifier: TaskDetailsTableViewCell.identifier)
//        table.register(SwitchTaskDetailsTableViewCell.self, forCellReuseIdentifier: SwitchTaskDetailsTableViewCell.identifier)
//        table.register(DatePickerTaskDetailsTableViewCell.self, forCellReuseIdentifier: DatePickerTaskDetailsTableViewCell.identifier)
//        table.register(TextFieldTaskDetailsTableViewCell.self, forCellReuseIdentifier: TextFieldTaskDetailsTableViewCell.identifier)
//        table.register(DeleteTableViewCell.self, forCellReuseIdentifier: DeleteTableViewCell.identifier)
//        table.register(TextViewTaskDetailsTableViewCell.self, forCellReuseIdentifier: TextViewTaskDetailsTableViewCell.identifier)
//        table.registerCell(type: TagsTableViewCell.self, identifier: TagsTableViewCell.identifier)
//        table.register(PickerTaskDetailsTableViewCell.self, forCellReuseIdentifier: PickerTaskDetailsTableViewCell.identifier)
//
//        return table
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configure()
//        title = "Task Details"
//        view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.frame = view.bounds
//    }
//
//    var models = [Section]()
//
//    func calculateTime(timeValue :Date,type: Int, no : Int) -> Date{
//        if type == 0 {
//            return timeValue
//        }
//        else if type == 1 {
//            if let date = Calendar.current.date(byAdding: .minute, value: -1*no, to: timeValue) {
//                return date
////                self.moveToDate = date
//            }
//        }
//        else if type == 2 {
//            if let date = Calendar.current.date(byAdding: .hour, value: -1*no, to: timeValue) {
//                return date
////                self.moveToDate = date
//            }
//        }
//        else if type == 3 {
//            if let date = Calendar.current.date(byAdding: .day, value: -1*no, to: timeValue) {
//                return date
////                self.moveToDate = date
//            }
//        }
//        return timeValue
//    }
//
//    func configure() {
//        models.append(Section(title: "Task Title", options: [
//            .textFieldCell(model: TaskTextFieldOption(title: "Title Text Field" ,handler: {
//
//            }, cellHeight: 0, noTag : 100,placeholder: "Task Title")),
//        ]))
//
//        models.append(Section(title: "Description", options: [
//            .textViewCell(model: TaskTextFieldOption(title: "Description" , handler: {
//
//            }, cellHeight: 0, noTag : 101, placeholder: "Description Here")),
//
//        ]))
//
//        models.append(Section(title: "Tags", options: [
//            .tagsCell(model: TaskTagsOption(title: "Tags", tagTitle: [], handler: {
//
//            })),
//        ]))
//
//        models.append(Section(title: "Set Priority", options: [
//            .switchCell(model: TaskSwitchOption(title: "Urgent", icon: UIImage(systemName: "exclamationmark.triangle"), handler: {
//
//                }, isOn: true, noTag: 31)),
//            .switchCell(model: TaskSwitchOption(title: "Important", icon: UIImage(systemName: "star"), handler: {
//
//            }, isOn: true, noTag: 32)),
//            .staticCell(model: TaskOption(title: "Priority", icon: UIImage(systemName: "folder"), handler: {
//
//            })),
//
//        ]))
//
//        models.append(Section(title: "", options: [
//            .switchCell(model: TaskSwitchOption(title: "Due Date", icon: UIImage(systemName: "calendar"), handler: {
//
//            }, isOn: self.dueDateOn, noTag: 41)),
//            .datePickerCell(model: TaskDatePickerOption(title: "Date", icon: UIImage(systemName: "calendar.badge.clock"), handler: {
//
//            }, date: Date())),
//            .pickerCell(model: TaskPickerOption(title: "Reminder", icon: UIImage(systemName: "bell"), handler: {
//
//            }, option1: Array(1...60), option2: ["None","minutes Before","hours Before","days before"], noTag: 51)),
//            .pickerCell(model: TaskPickerOption(title: "Move to Do Now", icon: UIImage(systemName: "exclamationmark.triangle.fill"), handler: {
//
//            }, option1: Array(1...60), option2: ["None","minutes Before","hours Before","days before"], noTag: 52)),
//
//
//        ]))
//
////        if (self.isEdit == True) {
////        models.append(Section(title: "", options: [
////            .buttonCell(model: TaskButtonOption(title: "Delete Task", icon: UIImage(systemName: "trash"), handler: {
////
////            }))
////
////
////
////        ]))
////        }
//
//
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier ==  "toAddTags" {
//            guard let destination = segue.destination as? AddTagsViewController else { return }
//            print("this doesnt work")
//            print(self.tags)
//            destination.taskTags = self.tags
//            print(destination.taskTags)
//
//        }
//    }
//
//
//    @IBAction func unwindTo(segue: UIStoryboardSegue) {
//        self.tableView.reloadSections([2], with: .none)
//      }
//
//}
//
//extension TaskDetailsViewController : UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return models.count
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let section = models[section]
//        return section.title
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        if (dueDateOn == false && section == 4) {
//            self.dueDate = nil
//            return 1
//        }
//
//        return models[section].options.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let model = models[indexPath.section].options[indexPath.row]
//
//        switch model.self {
//        case .staticCell(let model):
//            guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: TaskDetailsTableViewCell.identifier,
//                for: indexPath
//            ) as? TaskDetailsTableViewCell else {
//                return UITableViewCell()
//            }
//
//            cell.configure(with: model, task: self.Task!)
//            return cell
//
//        case .switchCell(let model) :
//            guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: SwitchTaskDetailsTableViewCell.identifier,
//                for: indexPath
//            ) as? SwitchTaskDetailsTableViewCell else {
//                return UITableViewCell()
//            }
//
//            if indexPath.section == 4 {
//                cell.delegate = self
//                cell.configure(with: model, value: self.dueDateOn)
//            } else {
//                cell.delegate = self
//                cell.configure(with: model)
//            }
//            return cell
//
//        case .datePickerCell(let model) :
//            guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: DatePickerTaskDetailsTableViewCell.identifier,
//                for: indexPath
//            ) as? DatePickerTaskDetailsTableViewCell else {
//                return UITableViewCell()
//            }
//            
//            //if editing
//            
//            cell.delegate = self
//            cell.configure(with: model)
//            
//            return cell
//
//        case .textFieldCell(let model) :
//            guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: TextFieldTaskDetailsTableViewCell.identifier,
//                for: indexPath
//            ) as? TextFieldTaskDetailsTableViewCell else {
//                return UITableViewCell()
//            }
//
//            cell.configure(with: model)
//            return cell
//
//        case .tagsCell(let model) :
//            guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: TagsTableViewCell.identifier,
//                for: indexPath
//            ) as? TagsTableViewCell else {
//                return UITableViewCell()
//            }
//
//            cell.delegate = self
//            cell.configure(with: model,tagsArray : self.taskTags!)
//
//            return cell
//        case .textViewCell(let model) :
//            guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: TextViewTaskDetailsTableViewCell.identifier,
//                for: indexPath
//            ) as? TextViewTaskDetailsTableViewCell else {
//                return UITableViewCell()
//            }
//
//            cell.configure(with: model)
//            return cell
//
//        case .buttonCell(let model) :
//            guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: DeleteTableViewCell.identifier,
//                for: indexPath
//            ) as? DeleteTableViewCell else {
//                return UITableViewCell()
//            }
//
//            cell.configure(with: model)
//            return cell
//
//        case .pickerCell(let model) :
//            guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: PickerTaskDetailsTableViewCell.identifier,
//                for: indexPath
//            ) as? PickerTaskDetailsTableViewCell else {
//                return UITableViewCell()
//            }
//
//            if(model.title == "Reminder") {
//                cell.configure(with: model,timeValue: reminder ?? "")
//            }
//                else {
//                cell.configure(with: model,timeValue: moveTo ?? "")
//            }
//            cell.delegate = self
//            return cell
//
//        }
//    }
//
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
//            model.handler()
//        }
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        switch indexPath.section {
//        case 1 :
//            return 88
//        case 2 :
//            return 66
//        default :
//            return 44
//        }
//
//    }
//
//
//
//
//}
//
//extension TaskDetailsViewController : SwitchTaskDetailsTableViewCellDelegate {
//    func dueDateTapped() {
//        let dueDate = self.dueDateOn
//        self.dueDateOn = !dueDate
//        updateDueDate()
//    }
//
//    func priorityTapped(noTag: Int) {
//        switch noTag {
//        case 31 :
//            let urgent = self.urgent
//            self.urgent = !urgent
//        case 32 :
//            let important = self.important
//            self.important = !important
//        case 41 :
//            break
//        default :
//            break
//        }
//        updatePriorites()
//    }
//}
//
//
//extension  TaskDetailsViewController : TagsTaskDetailsCollectionViewCellDelegate {
//    func addTagPage(tagArray: [String]) {
//    }
//
//    func addTagPage() {
//        performSegue(withIdentifier: "toAddTags", sender: self)
//    }
//}
//
//extension TaskDetailsViewController : PickerTaskDetailsTableViewCellDelegate {
//    func setMoveTo(no: Int, type: Int, text: String) {
//        self.moveTo = text
//
//        self.moveToValue = no
//        self.moveToTimeValue = type
//        if type == 0 {
//            self.moveToDate = dueDate
//        }
//        else if type == 1 {
//            if let date = Calendar.current.date(byAdding: .minute, value: -1*no, to: dueDate!) {
//                self.moveToDate = date
//            }
//        }
//        else if type == 2 {
//            if let date = Calendar.current.date(byAdding: .hour, value: -1*no, to: dueDate!) {
//                self.moveToDate = date
//            }
//        }
//        else if type == 3 {
//            if let date = Calendar.current.date(byAdding: .day, value: -1*no, to: dueDate!) {
//                self.moveToDate = date
//            }
//            reloadInputViews()
//        }
//
//
//    }
//    func setDate(no: Int, type: Int, text: String) {
//        self.reminder = text
//        self.reminderValue = no
//        self.reminderTimeValue = type
//
//        if type == 0 {
//            self.reminderDate = dueDate
//        }
//        else if type == 1 {
//            if let date = Calendar.current.date(byAdding: .minute, value: -1*no, to: dueDate!) {
//                self.reminderDate = date
//            }
//        }
//        else if type == 2 {
//            if let date = Calendar.current.date(byAdding: .hour, value: -1*no, to: dueDate!) {
//                self.reminderDate = date
//            }
//        }
//        else if type == 3 {
//            if let date = Calendar.current.date(byAdding: .day, value: -1*no, to: dueDate!) {
//                self.reminderDate = date
//
//            }
//        }
//
//    }
//}
//
//extension TaskDetailsViewController : DatePickerTaskDetailsTableViewCellDelegate {
//    func updateDueDate(date: Date) {
//        self.dueDate = date
//        setDate(no: self.reminderValue, type: self.reminderValue, text: self.reminder)
//        setMoveTo(no: self.moveToValue, type: self.moveToTimeValue, text: self.moveTo)
//
//    }
//}
