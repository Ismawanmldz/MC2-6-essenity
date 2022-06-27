//
//  AddTagsTagsTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 26/06/22.
//

import UIKit

class AddTagsTagsTableViewCell: UITableViewCell {

    var allTags : [String] = ["Assignment","Exam","Project"].sorted()
    var tagsChosen : [String] = ["Assignment","Exam"]
    var tagsToSave : [String]?
    
    static let identifier = "TagsTableViewCell"
    
    var delegate : TagsTaskDetailsCollectionViewCellDelegate?
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self

        /// Register NIB for collection view cell
        tagsCollectionView.registerCell(type: AddTagsTagsCollectionViewCell.self, identifier: "AddTagsTagsCollectionViewCell")
        tagsCollectionView.registerCell(type: TagsTaskDetailsCollectionViewCell.self, identifier: "TagsTaskDetailsCollectionViewCell")
        tagsCollectionView.showsHorizontalScrollIndicator = false
//        tagsCollectionView.contentInset = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10)
        tagsCollectionView.isScrollEnabled = false
        
        tagsCollectionView.backgroundColor = .systemGray5
        
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        tagsCollectionView.collectionViewLayout = collectionFlowLayout
        tagsCollectionView.reloadData()
        
        
    }
    
    override func layoutSubviews() {
        
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    public func configure(with model: TaskTagsOption, tagsArray : [String]){
        self.allTags = tagsArray
        tagsCollectionView.reloadData()
        
    }
    

    
}



extension AddTagsTagsTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = tagsCollectionView.dequeueReusableCell(
            withReuseIdentifier: "AddTagsTagsCollectionViewCell",
            for: indexPath) as! AddTagsTagsCollectionViewCell
        
        
        cell.type = allTags[indexPath.row]
        
        if(tagsChosen.contains(allTags[indexPath.row]) ){
            cell.backgroundColor = .systemBlue
            cell.tagLabel.textColor = .white
        }else {
            cell.backgroundColor = .gray
            cell.tagLabel.textColor = .black
        }
//        cell.backgroundColor = .gray
//        cell.tagLabel.textColor = .black
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(tagsChosen.contains(allTags[indexPath.row]) ){
            let indexOf = tagsChosen.firstIndex(of: allTags[indexPath.row])!
            tagsChosen.remove(at: indexOf)
            print("works")
            self.tagsCollectionView.reloadData()
        } else {
            tagsChosen.append(allTags[indexPath.row])
            self.tagsCollectionView.reloadData()
        }
        
        print(tagsChosen)
        
        if(indexPath.row == 0 ){
            delegate?.addTagPage()
            reloadInputViews()
        }
    }

    
}

