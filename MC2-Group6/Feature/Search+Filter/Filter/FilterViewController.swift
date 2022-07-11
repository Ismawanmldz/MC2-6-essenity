//
//  FilterViewController.swift
//  MC2-Group6
//
//  Created by Hana Salsabila on 27/06/22.
//

import UIKit

class FilterViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var taskCollectionView: UICollectionView?
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    let taskRepository = TaskRepository.shared
    
    var tempTag : [Tags] = []
    var allTags : [String] = ["Assignment","Exam","Project","Exam"].sorted()
    var tagsChosen = [String] ()
    
    var filterStatus : Bool = true
    
    var tagIndex = 0
    var tagList = [TagFilter]()
    var filteredTag = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        taskCollectionView!.showsHorizontalScrollIndicator = false
        taskCollectionView!.isScrollEnabled = false
        taskCollectionView!.backgroundColor = .clear
        
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        taskCollectionView!.collectionViewLayout = collectionFlowLayout
        taskCollectionView!.reloadData()
        
        doneBtn.tintColor = .darkBlue
        backBtn.tintColor = .darkBlue
        backBtn.titleLabel?.textColor = .black
        
        fetchTags()
    }
    
    func fetchTags() {
         do {
             self.tempTag = try taskRepository.context.fetch(Tags.fetchRequest())
             let sortedTag = tempTag.sorted{$0.tagTitle! < $1.tagTitle!}
             self.tempTag = sortedTag

             DispatchQueue.main.async {
                 self.taskCollectionView!.reloadData()
             }
         } catch{
             
         }
     }
    
    public func configure(with model: TaskTagsOption, tagsArray : [String]){
        self.tagsChosen = tagsArray
        fetchTags()
    }
    
    public func reloadCollection() {
        taskCollectionView!.reloadData()
    }
    
    //Back Action to the Search Page
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Passing Array to Search View COntroller
    @IBAction func doneBtnClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindFromFilter", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromFilter" {
            let navVC = segue.destination as! UINavigationController

            let destination = navVC.viewControllers.first as! SearchViewController

            destination.myIncomeArray = self.tagsChosen
//        filteredTag = tagsChosen
            print("send array")
            print(filteredTag)
            
            if tagsChosen.isEmpty == false {
                destination.filterButton.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle.fill"), for: .normal)
            } else {
                destination.filterButton.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
            }
        }
    }
//
}

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempTag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let taskCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagFilterCollectionViewCellID", for: indexPath) as! TagFilterCollectionViewCell
        
        let thisFilter = tempTag[indexPath.row]
        
        taskCollectionViewCell.tagButton.setTitle(thisFilter.tagTitle, for: .normal)
        taskCollectionViewCell.tagButton.layer.cornerRadius = 10

        taskCollectionViewCell.tagButton.contentEdgeInsets = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10)
        
        taskCollectionViewCell.tagButton.sizeToFit()
//        taskCollectionViewCell.sizeToFit()
        
        if(tagsChosen.contains(thisFilter.tagTitle!)) {
            taskCollectionViewCell.tagButton.backgroundColor = .darkBlue
            taskCollectionViewCell.tagButton.titleLabel?.textColor = .white
        } else {
            taskCollectionViewCell.tagButton.backgroundColor = .systemGray4
            taskCollectionViewCell.tagButton.titleLabel?.textColor = .black
        }
        
        if (thisFilter.isTag == true) {
            taskCollectionViewCell.tagButton.backgroundColor = .darkBlue
            taskCollectionViewCell.tagButton.titleLabel?.textColor = .white
        } else if (thisFilter.isTag == false){
            taskCollectionViewCell.tagButton.backgroundColor = .systemGray4
            taskCollectionViewCell.tagButton.titleLabel?.textColor = .black
        }
        
        
        //To click the button in collection view
        taskCollectionViewCell.callbackTag = {
            thisFilter.isTag = !thisFilter.isTag
            taskCollectionViewCell.tagButton.isSelected = thisFilter.isTag
                if(taskCollectionViewCell.tagButton.isSelected ) {
                    taskCollectionViewCell.tagButton.backgroundColor = .darkBlue
                    taskCollectionViewCell.tagButton.titleLabel?.textColor = .white
                    //To add spesific selected button tag to array filteredTag
                    self.tagsChosen.append(thisFilter.tagTitle!)
                    print("tambah tag " + thisFilter.tagTitle!)
                } else {
                    taskCollectionViewCell.tagButton.backgroundColor = .systemGray4
                    taskCollectionViewCell.tagButton.titleLabel?.textColor = .black
                    //To delete spesific selected button tag from array filteredTag
                    self.tagsChosen.remove(object: thisFilter.tagTitle!)
                    print("hapus tag " + thisFilter.tagTitle!)
                }
                print("filter array ")
                print(self.tagsChosen)
            }
        return taskCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let taskCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagFilterCollectionViewCellID", for: indexPath) as! TagFilterCollectionViewCell
        let width = taskCollectionViewCell.tagButton.frame.width
        let height = taskCollectionViewCell.tagButton.frame.height
        return CGSize(width: width, height: height)
    }
}

//To remove spesific array
extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
}

