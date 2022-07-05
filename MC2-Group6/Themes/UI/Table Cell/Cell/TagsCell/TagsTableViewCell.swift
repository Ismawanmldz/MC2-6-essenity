//
//  TagsTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 22/06/22.
//

import UIKit

class TagsTableViewCell: UITableViewCell {

    var arr : [String] = ["+ Add Tags"]
    var allTags : [String] = []
    var tagsChosen : [String] = [""]
    
    
    static let identifier = "TagsTableViewCell"
    
    var delegate : TagsTaskDetailsCollectionViewCellDelegate?
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self

        /// Register NIB for collection view cell
        tagsCollectionView.registerCell(type: TagsTaskDetailsCollectionViewCell.self, identifier: "TagsTaskDetailsCollectionViewCell")
        tagsCollectionView.showsHorizontalScrollIndicator = false
        tagsCollectionView.contentInset = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10)
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    public func configure(with model: TaskTagsOption,tagsArray : [String]){
        tagsChosen = tagsArray
        self.tagsChosen.insert(contentsOf: arr, at: 0)
        tagsCollectionView.reloadData()
    }
    
    public func configure(with model: TaskTagsOption, task : Task){
        tagsChosen = task.tags ?? []
        self.tagsChosen.insert(contentsOf: arr, at: 0)
        tagsCollectionView.reloadData()
    }
    
    
}

extension TagsTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsChosen.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = tagsCollectionView.dequeueReusableCell(
            withReuseIdentifier: "TagsTaskDetailsCollectionViewCell",
            for: indexPath) as! TagsTaskDetailsCollectionViewCell
        
        cell.type = tagsChosen[indexPath.row]
      
        
        if(indexPath.row == 0){
            cell.backgroundColor = .white
            cell.tagLabel.textColor = .systemGray2
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.systemGray2.cgColor
            cell.clipsToBounds = true
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row == 0 ){
            delegate?.toTagPage()
        }
    }

}
