//
//  ViewControllerTask.swift
//  MC2-Group6
//
//  Created by Ismawan Maulidza on 6/27/22.
//

import UIKit
import CoreData

class TaskPageViewController: UIViewController {
   
    let taskRepository = TaskRepository.shared
    
    @IBOutlet weak var todaysDate: UILabel!
    @IBOutlet weak var TaskCell: UICollectionView!
    @IBOutlet weak var TaskTable: UITableView!
    
    var taskContainer : [Task] = []
    
    var priorityNow : String?
    
    private var taskIndexEdit : Int?
    
    @IBOutlet weak var BackGroundViewWhite: UIView!
    
    
    var priorityCategories : [Priority] = []
    
    var TaskList = [TaskMainPage]()
    var TaskList2 = [TaskMainPage]()
    
    var filterTask = [TaskMainPage]()
    
    @IBAction func searchButtonPressed(_ sender: UIButton){
        performSegue(withIdentifier: "toSearchPage", sender: self)
    }
    
    @IBAction func addTaskButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toAddTaskPage", sender: self)
    }
    
    func refreshTable() {
        DispatchQueue.main.async {
//            self.fetchDoNow()
            self.TaskCell.reloadData()
//            self.TaskTable.r
//            self.TaskTable.reloadSections([0], with: .fade)
//            self.TaskTable.reloadSections([0], with: .fade
            
        }
    }
    
    
    func fetchPriorites() {
        do {
            let request = Priority.fetchRequest() as NSFetchRequest<Priority>
            
            
            
            self.priorityCategories = try taskRepository.context.fetch(request)
            
            DispatchQueue.main.async {
                self.TaskCell.reloadData()
            }
        }
        catch {
            
        }
    }
    
    func fetchDoNow() {
        do {
            let request = Task.fetchRequest() as NSFetchRequest<Task>
            let pred = NSPredicate(format: "priorities.title == %@", "Do Now")
            request.predicate = pred
            let tasks = try taskRepository.context.fetch(request)
            self.taskContainer = tasks
            self.TaskTable.reloadSections([0], with: .fade)
                                          self.priorityNow = "Do Now"
            
            
        } catch {
            
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchDoNow()
        self.TaskCell.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "E, dd/MM/yy"
        todaysDate.text = dateFormater.string(from: Date())
        TaskTable.showsVerticalScrollIndicator = false
        fetchDoNow()
        
        
        fetchPriorites()
        let nibCell = UINib(nibName: "CollectionViewCell", bundle: nil)
        TaskCell.register(nibCell, forCellWithReuseIdentifier: "TaskCell")
        
        
        let nibCell2 = UINib(nibName: "TableViewCell", bundle: nil)
        TaskTable.register(nibCell2, forCellReuseIdentifier: "TaskTableCell")
        
        BackGroundViewWhite.layer.cornerRadius = 30
        
    }
    
    //
 
        
    @IBAction func unwind(segue: UIStoryboardSegue) {
//        tableView.reloadData()
        self.TaskCell.reloadData()
        self.TaskTable.reloadData()
        
      }
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
//        tableView.reloadData()
        self.TaskCell.reloadData()
        self.TaskTable.reloadData()
        
      }
    
    
    func initList()
        {
            let task1 = TaskMainPage(title: "My First Task", description: "Yeay >,<", dueDate: "Today", tags: ["Assignment"], priority: "Do Now", status: "Uncomplete", check: "circle")
            let task2 = TaskMainPage(title: "My Second Task", description: "Yeay >,<", dueDate: "Today", tags: ["Exam"], priority: "Do Now", status: "Uncomplete", check: "circle")
            let task3 = TaskMainPage(title: "My Third Task", description: "Yeay >,<", dueDate: "Today", tags: ["Homework"], priority: "Do Now", status: "Completed", check: "circle.fill")
            let task4 = TaskMainPage(title: "My 1 Task", description: "Yeay >,<", dueDate: "Today", tags: ["Assignment"], priority: "Do Now", status: "Completed", check: "circle.fill")
            let task5 = TaskMainPage(title: "My 2 Task", description: "Yeay >,<", dueDate: "Today", tags: ["Assignment"], priority: "Do Now", status: "Completed", check: "circle.fill")
            let task6 = TaskMainPage(title: "My 3 Task", description: "Yeay >,<", dueDate: "Today", tags: ["Assignment"], priority: "Do Now", status: "Uncomplete", check: "circle")

            TaskList.append(task1)
            TaskList2.append(task1)
            TaskList.append(task2)
            TaskList.append(task3)
            TaskList.append(task4)
            TaskList.append(task5)
            TaskList.append(task6)

        }
    
    func viewToEdit() {
        performSegue(withIdentifier: "toEditTask", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditTask" {
            let navVC = segue.destination as! UINavigationController

            let destination = navVC.viewControllers.first as! EditTaskViewController

            destination.currentTask = self.taskContainer[taskIndexEdit!]
            print("")
            print(destination.currentTask?.tags)
            destination.currentIndex = self.taskIndexEdit
            
        
                if segue.identifier == "toAddTags" {
                    
                    let navVC = segue.destination as! UINavigationController

                    let destination = navVC.viewControllers.first as! AddTaskViewController

                    destination.delegate = self
                    
                }

    
        
        }
    }
}



// collection view My priorities

extension TaskPageViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
}

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    do {
        let request = Task.fetchRequest() as NSFetchRequest<Task>
        let pred = NSPredicate(format: "priorities.title == %@", taskPriority[indexPath.row])
        request.predicate = pred
        let tasks = try taskRepository.context.fetch(request)
        self.taskContainer = tasks
        self.TaskTable.reloadSections([0], with: .fade)
        self.priorityNow = taskPriority[indexPath.row]
//        self.TaskTable.reloadData()
        
    } catch {
        
    }
    
//
//    if(indexPath.row == 0){
//        do {
//
//            let request = Priority.fetchRequest() as NSFetchRequest<Priority>
//            let pred = NSPredicate(format: "title == %@", taskPriority[indexPath.row])
//            request.predicate = pred
//            let priority = try taskRepository.context.fetch(request)
//            cell.TaskNumber.text = String(priority[0].tasks!.count)
//            cell.TaskPriority.text = taskPriority[indexPath.row]
//        } catch {
//
//        }
//    }
//    else if (indexPath.row == 1){
//        self.filterTask = TaskList2
//        self.TaskTable.reloadData()
//    }
        
}
    
    
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = TaskCell.dequeueReusableCell(withReuseIdentifier: "TaskCell", for: indexPath)
        as! CollectionViewCell
    cell.delegate = self
    do {
        
    
        let request = Priority.fetchRequest() as NSFetchRequest<Priority>
        let pred = NSPredicate(format: "title == %@", taskPriority[indexPath.row])
        request.predicate = pred
        let priority = try taskRepository.context.fetch(request)
        cell.TaskNumber.text = String(priority[0].tasks!.count)
        cell.TaskPriority.text = taskPriority[indexPath.row]
    
    } catch {
        
    }
        
    let backgroundColorIndex = indexPath.row

    switch backgroundColorIndex {
    case 0:
        cell.contentView.backgroundColor = UIColor.red1
        
//        users = users.filter { $0.pets.contains(where: { petArr.contains($0) }) }
        filterTask = TaskList.filter { $0.priority.contains("Do Now")}
        
    case 1:
        cell.contentView.backgroundColor = UIColor.orange2

    case 2:
        cell.contentView.backgroundColor = UIColor.blue1
        
    case 3:
        cell.contentView.backgroundColor = UIColor.green2

    default:
        cell.contentView.backgroundColor = UIColor.blue1
        
    }
    
    return cell
    
    }
    
}


//=======================================================================

//Table view My Task

extension TaskPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return taskContainer.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TaskTable.dequeueReusableCell(withIdentifier: "TaskTableCell", for: indexPath)
            as! TableViewCell
        
//        let thisTask = filterTask[indexPath.row]
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "d MMM"
        let taskDate = dateFormater.string(from: taskContainer[indexPath.row].dueDate!)
        
        cell.TaskName.text = taskContainer[indexPath.row].title
        cell.TaskTag.text = taskContainer[indexPath.row].desc
        cell.TaskDate.text = dateFormater.string(from: taskContainer[indexPath.row].dueDate!)
//        cell.TaskTag.text = taskContainer[indexPath.row].tags
        
        cell.delegate = self
//
        if indexPath.section == 0 {
            cell.viewTableCell.backgroundColor = UIColor.red1
        }else if (indexPath.section == 1){
            cell.viewTableCell.backgroundColor = UIColor.orange2
        }else if (indexPath.section == 2) {
            cell.viewTableCell.backgroundColor = UIColor.blue1
        }else if (indexPath.section == 3){
            cell.viewTableCell.backgroundColor = UIColor.green2

        }
        
        
        
        cell.viewTableCell.layer.cornerRadius = 8
        cell.viewTableCell.layer.masksToBounds = true
        cell.viewTableCell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        cell.layer.cornerRadius = 8
        cell.viewBackgroundTable.layer.cornerRadius = 8
        
        //To click check button and change the button image
        
        
        cell.checkButton.isSelected = taskContainer[indexPath.row].status == true
        

        cell.callback = {
            self.taskContainer[indexPath.row].status = !self.taskContainer[indexPath.row].status
            cell.checkButton.isSelected = self.taskContainer[indexPath.row].status
            if(cell.checkButton.isSelected){
                cell.checkButton.setImage(UIImage(systemName: "circle.fill"), for: .selected)
                do {
                    let request = Priority.fetchRequest() as NSFetchRequest<Priority>

                    let pred = NSPredicate(format: "title == %@", "Complete")
                    request.predicate = pred

                    let priority = try self.taskRepository.context.fetch(request)
                    self.taskContainer[indexPath.row].priorities   = priority[0]
                    self.fetchDoNow()
                    try self.taskRepository.context.save()
                }
                catch {

                }
            } else {
                cell.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
                    }
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
//=======================================================================
    
    //fungsi untuk mendelete tasklist di tableview
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:IndexPath) {
        if editingStyle == .delete {
                tableView.beginUpdates()
            let alert = UIAlertController(title: "Delete ", message: "Are you sure you want to to back. All progress will be lost!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                let taskToDelete = self.taskContainer[indexPath.row]
                self.taskRepository.context.delete(taskToDelete)
                
                do {
                    try self.taskRepository.context.save()
//                    self.dismiss(animated: true)
                    DispatchQueue.main.async {
                        self.fetchDoNow()
                        self.TaskCell.reloadData()
                        
                    }
                }
                catch {
                    
                }
            
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.dismiss(animated: true)
        }
                tableView.endUpdates()
            }
        
    
    //==============================================
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.taskIndexEdit = indexPath.row
        
        performSegue(withIdentifier: "toEditTask", sender: self)
        
    }
    
    
    
    
}



extension TaskPageViewController : AddTaskViewControllerDelegate {
    func reloadData() {
        print("delegate")
        self.TaskTable.reloadData()
        self.TaskCell.reloadData()
    }
}

extension TaskPageViewController : TableViewCellMainDelegate {
    func reloadAll() {
        TaskCell.reloadData()
        TaskTable.reloadSections([0], with: .fade)
    }
}

extension TaskPageViewController : CollectionViewCellDelegate {
    func toInfoPage() {
        if self.priorityNow == "Do Now"{
            performSegue(withIdentifier: "toDoNow", sender: self)
        } else if(self.priorityNow == "Plan It"){
            performSegue(withIdentifier: "toPlanIt", sender: self)
        }else if(self.priorityNow == "Delegate"){
            performSegue(withIdentifier: "toDelegate", sender: self)
        }else if(self.priorityNow == "Eliminate"){
            performSegue(withIdentifier: "toEliminate", sender: self)
        }
        
        
        
    }
}
