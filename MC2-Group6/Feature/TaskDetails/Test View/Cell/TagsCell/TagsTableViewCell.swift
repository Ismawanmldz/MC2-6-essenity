//
//  TagsTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 22/06/22.
//

import UIKit

class TagsTableViewCell: UITableViewCell {

    let arr : [String] = ["+ Add Tags","Assignment","Exam","Assignment","Project"]
    
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
        
//        let collectionFlowLayout = UICollectionViewFlowLayout()
////            collectionFlowLayout.scrollDirection = .vertical
//            collectionFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//            tagsCollectionView.collectionViewLayout = collectionFlowLayout
//
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .horizontal
              collectionFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
              tagsCollectionView.collectionViewLayout = collectionFlowLayout
        
        
        
    }

    
}

extension TagsTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = tagsCollectionView.dequeueReusableCell(
            withReuseIdentifier: "TagsTaskDetailsCollectionViewCell",
            for: indexPath) as! TagsTaskDetailsCollectionViewCell
        
        
        cell.type = arr[indexPath.row]
        cell.backgroundColor = .systemBlue
        
        if(indexPath.row == 0){
            cell.backgroundColor = .systemGray5
            cell.tagLabel.textColor = .black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row == 0 ){
            print("yay")
            delegate?.addTagPage()
        }
    }

}
