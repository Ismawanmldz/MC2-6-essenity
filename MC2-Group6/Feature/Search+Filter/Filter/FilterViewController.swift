//
//  FilterViewController.swift
//  MC2-Group6
//
//  Created by Hana Salsabila on 27/06/22.
//

import UIKit

class FilterViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var taskCollectionView: UICollectionView?
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var tagIndex = 0
    var tagList = [TagFilter]()
    var filteredTag = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initList()
    }
    
    func initList() {
        
        let filter1 = TagFilter(chooseFilterTag: "Assignment", filterColor: .systemGray4)
        let filter2 = TagFilter(chooseFilterTag: "Exam", filterColor: .systemGray4)
        let filter3 = TagFilter(chooseFilterTag: "Projects", filterColor: .systemGray4)
        let filter4 = TagFilter(chooseFilterTag: "Homework", filterColor: .systemGray4)
        
        tagList.append(filter1)
        tagList.append(filter2)
        tagList.append(filter3)
        tagList.append(filter4)

    }
    
    //Back Action to the Search Page
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Passing Array to Search View COntroller
    @IBAction func doneBtnClicked(_ sender: UIButton) {
        
        if let FVC = storyboard?.instantiateViewController(withIdentifier: "searchViewControllerID") as? SearchViewController {
            
            FVC.mySeguedArray = filteredTag
            print("array dari FVC")
            print(FVC.mySeguedArray)
            
//            navigationController?.pushViewController(FVC, animated: true)
            self.dismiss(animated: true, completion: nil)
        } else {
            print("Data NOT Passed! destination vc is not set to FVC")
        }
    }
}

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let taskCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagFilterCollectionViewCellID", for: indexPath) as! TagFilterCollectionViewCell
        
        let thisFilter = tagList[indexPath.row]
        
        taskCollectionViewCell.tagButton.setTitle(thisFilter.chooseFilterTag, for: .normal)
        taskCollectionViewCell.tagButton.layer.cornerRadius = 10
        taskCollectionViewCell.tagButton.backgroundColor = thisFilter.filterColor
        
        taskCollectionViewCell.tagButton.isSelected = thisFilter.isTag
        taskCollectionViewCell.tagButton.contentEdgeInsets = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10)
        taskCollectionViewCell.tagButton.sizeToFit()
        taskCollectionViewCell.sizeToFit()
        
        //To click the button in collection view
        taskCollectionViewCell.callbackTag = {
            thisFilter.isTag = !thisFilter.isTag
            taskCollectionViewCell.tagButton.isSelected = thisFilter.isTag
                if(taskCollectionViewCell.tagButton.isSelected ) {
                    taskCollectionViewCell.tagButton.backgroundColor = .darkBlue
//                    To add spesific selected button tag to array filteredTag
                    self.filteredTag.append(thisFilter.chooseFilterTag.lowercased())
                    print("tambah tag " + thisFilter.chooseFilterTag.lowercased())
                } else {
                    taskCollectionViewCell.tagButton.backgroundColor = .systemGray4
                    //To delete spesific selected button tag from array filteredTag
                    self.filteredTag.remove(object: thisFilter.chooseFilterTag.lowercased())
                    print("hapus tag " + thisFilter.chooseFilterTag.lowercased())
                }
                print("filter array ")
                print(self.filteredTag)
            }
        return taskCollectionViewCell
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

