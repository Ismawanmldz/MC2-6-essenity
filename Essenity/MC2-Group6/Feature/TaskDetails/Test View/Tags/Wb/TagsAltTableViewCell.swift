//
//  TagsWBTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 22/06/22.
//

import UIKit

class TagsAltTableViewCell: UITableViewCell {

    static let identifier = "TagsAltTableViewCell"
    
    @IBOutlet weak var tagsWBcolView: UICollectionView!
    
    var tagsAlt: SettingsTagsOption?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagsWBcolView.registerCell(type: TagsWBCollectionViewCell.self, identifier: TagsWBCollectionViewCell.identifier)
        tagsWBcolView.delegate = self
        tagsWBcolView.dataSource = self
        print("lol")
        
    }
    
    func setupView() {
        
    }
    
    public func configure(with model: SettingsTagsOption){

        self.tagsAlt = model
//        awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TagsAltTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tagsAlt?.tagTitle.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagsWBCollectionViewCell.identifier, for: indexPath) as! TagsWBCollectionViewCell
        cell.sizeToFit()
        cell.backgroundColor = .systemBlue
        cell.tagsWBTitle.text = self.tagsAlt?.tagTitle[indexPath.row]
        cell.type = tagsAlt?.tagTitle[indexPath.row]
        
        return cell
    }
}


