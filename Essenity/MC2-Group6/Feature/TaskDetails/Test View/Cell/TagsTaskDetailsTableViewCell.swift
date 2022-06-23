//
//  TagsTaskDetailsTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 21/06/22.
//

import UIKit

class TagsTaskDetailsTableViewCell: UITableViewCell {

    static let identifier = "TagsTaskDetailsTableViewCell"
    
    private var colView : UICollectionView?
    private var tagsOption : SettingsTagsOption?
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
//        layout.sectionInset
//        collectionView.registerCell(type: TagsTaskDetailsCollectionViewCell.self, identifier: TagsTaskDetailsCollectionViewCell.identifier)
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = collectionFlowLayout
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
//        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        
        contentView.addSubview(collectionView)
        contentView.clipsToBounds = true
        accessoryType = .none
        
        collectionView.register(TagsCollectionViewCell.self, forCellWithReuseIdentifier: TagsCollectionViewCell.identifier)
        collectionView.register(TestTagCell.self, forCellWithReuseIdentifier: TestTagCell.identifier)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.register(TagsTaskDetailsCollectionViewCell.self, forCellWithReuseIdentifier: TagsTaskDetailsCollectionViewCell.identifier)

        
//        collectionView.registerCell(type: TagsTaskDetailsCollectionViewCell.self, identifier: TagsTaskDetailsCollectionViewCell.identifier)
//        
////
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = collectionFlowLayout
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 0)
        collectionView.sizeToFit()
        collectionView.frame = CGRect(x:0, y:0, width: contentView.frame.width, height: contentView.frame.height)
        
//        collectionView.sizeToFit()
//        collectionView.frame = CGRect(x:0, y:0, width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
 
    }
    
    public func configure(with model: SettingsTagsOption){
        self.tagsOption = model
    }
    

}
//
//extension TagsTaskDetailsTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return 6
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        if indexPath.row < indexPath.endIndex {
//            let cell = UICollectionViewCell()
////        cell.setupView()
////        cell.tagTitle = "heyy"
//
////        cell.tagTitle = self.tagsOption?.tagTitle[indexPath.row]
////            cell.sizeToFit()
////            cell.configure(with: self.tagsOption!.tagTitle[indexPath.row])
//
//            return cell
//
////        }
////        else {
////            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestTagCell.identifier, for: indexPath) as! TestTagCell
////
////            cell.sizeToFit()
////            cell.contentView.backgroundColor = .systemRed
////            return cell
////
////        }
//
//
//    }
//
//
//
//
//
//
//}
