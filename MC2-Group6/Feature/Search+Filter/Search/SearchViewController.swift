//
//  SearchViewController.swift
//  MC2-Group6
//
//  Created by Hana Salsabila on 27/06/22.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    private let taskRepository = TaskRepository.shared
    
    var taskContainer : [Task]?
    var filteredTask = [Task]()
    
    //simpan array dari segmented control
    var segmentedControlTask = [Task]()
    //simpan array dari search
    var searchedTask = [Task]()
    //simpan array dari tag
    var filterTagTask = [Task]()
    
    var priorityTask = [Priority]()
    
    var searchActive : Bool = false
    var checkIndex = 0
    
    private var taskIndexEdit : Int?
    
    var priorityCategories : [Priority]?
    var priorityNow : String?
    
    //Receive Array
    var myIncomeArray : [String] = []
    
    func refreshTable() {
        DispatchQueue.main.async {
            self.taskTableView.reloadData()
        }
    }
    
    func fetchTasks() {
        do {
            self.taskContainer = try taskRepository.context.fetch(Task.fetchRequest())
            DispatchQueue.main.async {
                self.taskTableView.reloadData()
            }
        }
        catch {
        }
    }
    
    @IBAction func unwindFromFilter(sender: UIStoryboardSegue) {
        if sender.source is FilterViewController {
            if let senderVC = sender.source as? FilterViewController {
//        if segue.identifier = "unwindFromFrilter" {
                if senderVC.tagsChosen.isEmpty == false {
                    filterButton.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle.fill"), for: .normal)
                    filterButton.tintColor = .darkBlue
                } else {
                    filterButton.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
                    filterButton.tintColor = .darkBlue
                }
                
                myIncomeArray = senderVC.tagsChosen
                
                if  (myIncomeArray.count == 1) {
                    filterTagTask = taskContainer!.filter { $0.tags!.contains(where: { myIncomeArray.contains($0) }) }
                    print("dari seg")
                } else if (myIncomeArray.count >= 1){
                    filterTagTask = taskContainer!.filter { $0.tags! == myIncomeArray }
                    print("dari seg1")
                } else if myIncomeArray.isEmpty == true {
                    filterTagTask = taskContainer!
                }
                updateSearchResults(for: searchBar)
                
                taskTableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTasks()
        self.taskTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initSearchController()
        initSegmentedControl()
        filterButton.tintColor = .darkBlue
        backBtn.tintColor = .darkBlue
        
        fetchTasks()
        
        segmentedControl.selectedSegmentIndex = 0
        taskTableView.showsVerticalScrollIndicator = false
        
        updateSearchResults(for: searchBar)
        
        if(searchBar.text == "") {
            updateSearchResults(for: searchBar)
        }
        
        let nibCell2 = UINib(nibName: "TableViewCell", bundle: nil)
        taskTableView.register(nibCell2, forCellReuseIdentifier: "TaskTableCell")
    }
    
    //MARK: SEARCH CONTROLLER
    func initSearchController()
    {
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        searchBar.placeholder = "Search Your Task"

        navigationItem.hidesSearchBarWhenScrolling = false
        searchBar.delegate = self
    }
    
    //MARK: SEGMENTED CONTROL
    func initSegmentedControl() -> UISegmentedControl {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .darkBlue
        segmentedControl.tintColor = .darkBlue
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        return segmentedControl
    }
    
    func updateSearchResults(for searchBar: UISearchBar) {
        let searchBar = searchBar
        let scopeButton = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        let searchText = searchBar.text
        
        if (myIncomeArray.isEmpty) {
            filteredWithSegmentedControl(searchText: searchText!, scopeButton: scopeButton!)
        } else {
            filteredWithSegmentedControlAndTags(searchText: searchText!, scopeButton: scopeButton!)
        }
    }

    func filteredWithSegmentedControl(searchText: String, scopeButton: String)
    {
        print(myIncomeArray)
        if scopeButton.lowercased() == "completed" {
            print(scopeButton.lowercased())
            segmentedControlTask = taskContainer!.filter { $0.status == true }
            filteredTask = segmentedControlTask
        } else if (scopeButton.lowercased() == "uncomplete"){
            segmentedControlTask = taskContainer!.filter { $0.status == false }
            filteredTask = segmentedControlTask
        }
        
        
        
        print(scopeButton.lowercased())
        print("dari segmented button")
        print(filteredTask)
        taskTableView.reloadData()
    }
    
    func filteredWithSegmentedControlAndTags(searchText: String, scopeButton: String)
    {
        if scopeButton.lowercased() == "completed" {
            print(scopeButton.lowercased())
            segmentedControlTask = filterTagTask.filter { $0.status == true }
            filteredTask = segmentedControlTask
        } else if (scopeButton.lowercased() == "uncomplete"){
            segmentedControlTask = filterTagTask.filter { $0.status == false }
            filteredTask = segmentedControlTask
        }
        
        print(scopeButton.lowercased())
        print("dari segmented button")
        print(filteredTask)
        taskTableView.reloadData()
    }
    
    func viewToEdit() {
        performSegue(withIdentifier: "toEditTask", sender: self)
    }
    
    func valueChanged(segmentedControl: UISegmentedControl) {
        updateSearchResults(for: searchBar)
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        
        if(segmentedControl.selectedSegmentIndex == 0){
            updateSearchResults(for: searchBar)
        } else if(segmentedControl.selectedSegmentIndex == 1) {
            updateSearchResults(for: searchBar)
        } else if(searchActive) {
            updateSearchResults(for: searchBar)
        }
    }
    
    //
    @IBAction func filterBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toFilterPage", sender: nil)
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(searchActive) {
            return filteredTask.count
        }
        return segmentedControlTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let taskTableViewCell = tableView.dequeueReusableCell(withIdentifier: "taskTableViewCellID") as! TaskTableViewCell
        
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskTableCell", for: indexPath)
            as! TableViewCell
        
        let thisTask : Task?
        
//        searchActive = true
        if(searchActive){
            thisTask = filteredTask[indexPath.row]
        } else {
            thisTask = segmentedControlTask[indexPath.row]
        }
        
//        cell..text = thisTask!.title
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "d MMM"
        let taskDate = dateFormater.string(from: thisTask!.dueDate!)
        
        cell.TaskName.text = thisTask!.title
        cell.TaskTag.text = thisTask!.desc
        cell.TaskDate.text = dateFormater.string(from: thisTask!.dueDate!)
        
        if (thisTask!.priorities!.title == "Do Now") {
            cell.viewTableCell.backgroundColor = UIColor.red1
        }else if (thisTask!.priorities!.title == "Plan It"){
            cell.viewTableCell.backgroundColor = UIColor.orange2
        }else if (thisTask!.priorities!.title == "Delegate") {
            cell.viewTableCell.backgroundColor = UIColor.blue1
        }else if (thisTask!.priorities!.title == "Eleminate") {
            cell.viewTableCell.backgroundColor = UIColor.green2
        }
        
        cell.viewTableCell.layer.cornerRadius = 8
        cell.viewTableCell.layer.masksToBounds = true
        cell.viewTableCell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        cell.layer.cornerRadius = 8
        
        //To click check button and change the button image
        cell.checkButton.isSelected = thisTask!.status

        cell.callback = {
            thisTask!.status = thisTask!.status
            cell.checkButton.isSelected = thisTask!.status
            if(cell.checkButton.isSelected){
                cell.checkButton.setImage(UIImage(systemName: "circle.inset.fill"), for: .selected)
//                do {
//                    let request = Priority.fetchRequest() as NSFetchRequest<Priority>
//
//                    let pred = NSPredicate(format: "title == %@", "Complete")
//                    request.predicate = pred
//
//                    let priority = try self.taskRepository.context.fetch(request)
//                    self.taskContainer![indexPath.row].priorities   = priority[0]
//                    self.fetchTasks()
//                    try self.taskRepository.context.save()
//                }
//                catch {
//                }
            } else {
                cell.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //fungsi untuk mendelete tasklist di tableview
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:IndexPath) {
        if editingStyle == .delete {
                tableView.beginUpdates()
            let alert = UIAlertController(title: "Delete ", message: "Are you sure you want to to back. All progress will be lost!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                let taskToDelete = self.taskContainer![indexPath.row]
                self.taskRepository.context.delete(taskToDelete)
                do {
                    try self.taskRepository.context.save()

                    DispatchQueue.main.async {
                        self.fetchTasks()
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
        
    //MARK:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.taskIndexEdit = indexPath.row
        
        performSegue(withIdentifier: "toEditTask", sender: self)
        
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    //MARK: Search Bar
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchActive = true
        return searchActive
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchActive = true
        return searchActive
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
           searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
           searchActive = false;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searchActive = false;
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           searchActive = false;
    }
    
    //To search by text in search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            searchedTask = segmentedControlTask.filter { $0.title!.contains(searchText) }
            searchActive = true
            filteredTask = searchedTask
            self.taskTableView.reloadData()
        } else {
            filteredTask = segmentedControlTask
            searchActive = false
            self.taskTableView.reloadData()
        }
    }
}

