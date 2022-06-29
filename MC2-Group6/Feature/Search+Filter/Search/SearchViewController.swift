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
   
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    var taskList = [TaskSearch]()
    var filteredTask = [TaskSearch]()
    var searchActive : Bool = true
    var checkIndex = 0
    
    //Receive Array
    var myIncomeArray = [String]()
    var mySeguedArray = [String]() {
             didSet{
                 
                 myIncomeArray = mySeguedArray //no need to call viewDidLoad
                 filterButton.setImage(UIImage(named: "line.3.horizontal.decrease.circle.fill"), for: .normal)
                 print(myIncomeArray[0])
                 print("Array dari SVC")
                 print(myIncomeArray)
             }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initList()
        initSearchController()
        segmentedControl.selectedSegmentIndex = 0
        print("scopeFilter")
//        print(scopeFilter)
        updateSearchResults(for: searchBar)
        if(searchBar.text == "") {
            updateSearchResults(for: searchBar)
        }
        initSegmentedControl()
    }
    
    
    
    //MARK: Table View Cell
    func initList()
    {
        let task1 = TaskSearch(title: "My First Task", description: "Yeay >,<", dueDate: "Today", tags: ["Assignment"], priority: "Do Now", status: "Uncomplete", check: "circle")
        let task2 = TaskSearch(title: "My Second Task", description: "Yeay >,<", dueDate: "Today", tags: ["Exam"], priority: "Do Now", status: "Uncomplete", check: "circle")
        let task3 = TaskSearch(title: "My Third Task", description: "Yeay >,<", dueDate: "Today", tags: ["Homework"], priority: "Do Now", status: "Completed", check: "circle.fill")
        let task4 = TaskSearch(title: "My 1 Task", description: "Yeay >,<", dueDate: "Today", tags: ["Assignment"], priority: "Do Now", status: "Completed", check: "circle.fill")
        let task5 = TaskSearch(title: "My 2 Task", description: "Yeay >,<", dueDate: "Today", tags: ["Assignment"], priority: "Do Now", status: "Completed", check: "circle.fill")
        let task6 = TaskSearch(title: "My 3 Task", description: "Yeay >,<", dueDate: "Today", tags: ["Assignment"], priority: "Do Now", status: "Uncomplete", check: "circle")
        
        taskList.append(task1)
        taskList.append(task2)
        taskList.append(task3)
        taskList.append(task4)
        taskList.append(task5)
        taskList.append(task6)
        
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


        filteredForSearchTextAndScopeButton(searchText: searchText!, scopeButton: scopeButton!)
        
//        filteredForSearchTextAndScopeButton(scopeButton: scopeButton, scopeTag: )
    }

    func filteredForSearchTextAndScopeButton(searchText: String, scopeButton: String)
    {
//        var scopeFilter = taskList.filter({ myIncomeArray.contains($0.tags) })
//        print(scopeFilter)
        filteredTask = taskList.filter
        {
            task in
            let scopeMatch = (scopeButton == "All" || task.status!.lowercased().contains(scopeButton.lowercased()))
            return scopeMatch
        }
        print(scopeButton)
        
        taskTableView.reloadData()
        
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func valueChanged(segmentedControl: UISegmentedControl) {
//        if(segmentedControl.selectedSegmentIndex == 0){
//            updateSearchResults(for: searchBar)
//        } else if(segmentedControl.selectedSegmentIndex == 1){
//            updateSearchResults(for: searchBar)
//        }
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
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskTableViewCell = tableView.dequeueReusableCell(withIdentifier: "taskTableViewCellID") as! TaskTableViewCell
        
        let thisTask : TaskSearch!
        
//        searchActive = true
        if(searchActive){
            thisTask = filteredTask[indexPath.row]
        } else {
            thisTask = taskList[indexPath.row];
        }
        
        taskTableViewCell.taskTitle.text = thisTask.title
        taskTableViewCell.taskTags.text = thisTask.tags[0]
        taskTableViewCell.taskDueDate.text = thisTask.dueDate
        
        taskTableViewCell.taskPriority.backgroundColor = UIColor(red: 1.00, green: 0, blue: 0, alpha: 1.00)
        taskTableViewCell.taskView.layer.cornerRadius = 8
        
        // Make Priority Color in Table View Cell have corner edge
        taskTableViewCell.taskPriority.layer.cornerRadius = 8
        taskTableViewCell.taskPriority.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    
        
        taskTableViewCell.checkButton.setImage(UIImage(systemName: thisTask.check), for: .normal)
        
        
        if(taskTableViewCell.checkButton.currentImage == UIImage(systemName: "circle.fill")){
            taskTableViewCell.checkButton.isSelected = true
        }
        
        //To click check button and change the button image
        taskTableViewCell.checkButton.isSelected = thisTask.isFavorite
        taskTableViewCell.callback = {
            thisTask.isFavorite = !thisTask.isFavorite
            taskTableViewCell.checkButton.isSelected = thisTask.isFavorite
            if(taskTableViewCell.checkButton.isSelected){
                taskTableViewCell.checkButton.setImage(UIImage(systemName: "circle.fill"), for: .selected)
            } else {
                taskTableViewCell.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            }

        }

        return taskTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
                filteredTask = filteredTask.filter{ $0.title.contains(searchText)}
                searchActive = true
                self.taskTableView.reloadData()
            } else {
//                filteredTask = filteredTask
                searchActive = false
                self.taskTableView.reloadData()
            }
    }
}
