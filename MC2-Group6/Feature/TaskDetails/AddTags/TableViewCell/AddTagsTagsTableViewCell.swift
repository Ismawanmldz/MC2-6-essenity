//
//  AddTagsTagsTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 26/06/22.
//

import UIKit

class AddTagsTagsTableViewCell: UITableViewCell {

    let taskRepository = TaskRepository.shared
    
    var tempTag : [Tags] = []
    var allTags : [String] = ["Assignment","Exam","Project","Exam"].sorted()
    var tagsChosen : [String] = []
    var tagsToSave : [String]?
    
    static let identifier = "TagsTableViewCell"
    
    var delegate : TagsAddTagsCollectionViewCellDelegate?
    
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
        
        tagsCollectionView.backgroundColor = .clear
        
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        tagsCollectionView.collectionViewLayout = collectionFlowLayout
        tagsCollectionView.reloadData()
        fetchTags()
        
    }
    
    
   func fetchTags() {
        do {
            self.tempTag = try taskRepository.context.fetch(Tags.fetchRequest())
            let sortedTag = tempTag.sorted{$0.tagTitle! < $1.tagTitle!}
            self.tempTag = sortedTag
//            for (index, newTag) in tempTags.enumerated() {
//                tempStringTag.append(contentsOf: newTag.tagTitle)
//            }
            
            DispatchQueue.main.async {
                self.tagsCollectionView.reloadData()
            }
        } catch{
            
        }
    }
    
    override func layoutSubviews() {
        
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    public func configure(with model: TaskTagsOption, tagsArray : [String]){
        self.tagsChosen = tagsArray
        fetchTags()
        
    }
    
    public func reloadCollection() {
        tagsCollectionView.reloadData()
    }

    
}



extension AddTagsTagsTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempTag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = tagsCollectionView.dequeueReusableCell(
            withReuseIdentifier: "AddTagsTagsCollectionViewCell",
            for: indexPath) as! AddTagsTagsCollectionViewCell
        
        
        cell.type = tempTag[indexPath.row].tagTitle
        
        if(tagsChosen.contains(tempTag[indexPath.row].tagTitle!) ){
            cell.backgroundColor = .systemBlue
            cell.tagLabel.textColor = .white
        }else {
            cell.backgroundColor = .gray
            cell.tagLabel.textColor = .black
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(tagsChosen.contains(tempTag[indexPath.row].tagTitle!) ){
            let indexOf = tagsChosen.firstIndex(of: tempTag[indexPath.row].tagTitle!)!
            tagsChosen.remove(at: indexOf)
            print("works")
            self.tagsCollectionView.reloadData()
        } else {
            tagsChosen.append(tempTag[indexPath.row].tagTitle!)
            print("tagsChosen ")
            print(tagsChosen)
            self.tagsCollectionView.reloadData()
        }

        delegate?.addTagPage(tagArray: tagsChosen)
//        delegate?.addTagPage(tagArray : tagsChosen)
        
//        if(indexPath.row == 0 ){
//            delegate?.addTagPage(tagArray : tagsChosen)
//            reloadInputViews()
//        }
    }

    
}

extension  AddTagsTagsTableViewCell : AddTagsCollectionViewDelegate {
    func reloadPageCV(tagTitle : String) {
   
        delegate?.reloadDataTable()
        if(tagsChosen.contains(tagTitle) ){
            print(tagTitle)
            let indexOf = tagsChosen.firstIndex(of: tagTitle)
            tagsChosen.remove(at: indexOf!)
        }
        delegate?.addTagPage(tagArray: tagsChosen)
    }
}
