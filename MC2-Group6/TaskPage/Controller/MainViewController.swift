//
//  ViewControllerTask.swift
//  MC2-Group6
//
//  Created by Ismawan Maulidza on 6/27/22.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var TaskCell: UICollectionView!
    @IBOutlet weak var TaskTableCell: UITableView!
    
    @IBOutlet weak var BackGroundViewWhite: UIView!
    
    var TaskList = [TaskMainPage]()
    var TaskList2 = [TaskMainPage]()
    
    var filterTask = [TaskMainPage]()
    
    @IBAction func searchButtonPressed(_ sender: UIButton){
        performSegue(withIdentifier: "toSearchPage", sender: self)
    }
    
    @IBAction func addTaskButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toAddTaskPage", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initList()
        
        
        let nibCell = UINib(nibName: "CollectionViewCell", bundle: nil)
        TaskCell.register(nibCell, forCellWithReuseIdentifier: "TaskCell")
        
        
        let nibCell2 = UINib(nibName: "TableViewCell", bundle: nil)
        TaskTableCell.register(nibCell2, forCellReuseIdentifier: "TaskTableCell")
        
        BackGroundViewWhite.layer.cornerRadius = 30
        
    }
    
    //
    
    
    
    
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}


// collection view My priorities

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return taskNumber.count
}

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if(indexPath.row == 0){
//        print("hello")
        self.filterTask = TaskList2
        self.TaskTableCell.reloadData()
    }
    else if (indexPath.row == 1){
        self.filterTask = TaskList2
        self.TaskTableCell.reloadData()
    }
        
}
    
    
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = TaskCell.dequeueReusableCell(withReuseIdentifier: "TaskCell", for: indexPath)
        as! CollectionViewCell
    
    cell.TaskNumber.text = String(taskNumber[indexPath.row])
    cell.TaskPriority.text = taskPriority[indexPath.row]
    
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterTask.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TaskTableCell.dequeueReusableCell(withIdentifier: "TaskTableCell", for: indexPath)
            as! TableViewCell
        
        let thisTask = filterTask[indexPath.row]
        
        cell.TaskName.text = thisTask.title
        cell.TaskTag.text = thisTask.tags[0]
        cell.TaskDate.text = thisTask.dueDate
        
        
        cell.viewTableCell.layer.cornerRadius = 8
        cell.viewTableCell.layer.masksToBounds = true
        cell.viewTableCell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        cell.layer.cornerRadius = 8
        cell.viewBackgroundTable.layer.cornerRadius = 8
        
        //To click check button and change the button image
        
        
        cell.checkButton.isSelected = thisTask.isFavorite
        cell.callback = {
        thisTask.isFavorite = !thisTask.isFavorite
        cell.checkButton.isSelected = thisTask.isFavorite
            if(cell.checkButton.isSelected){
                cell.checkButton.setImage(UIImage(systemName: "circle.fill"), for: .selected)
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
                taskName.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
        
                tableView.endUpdates()
            }
        
    }
    //==============================================

    
    
    
}



