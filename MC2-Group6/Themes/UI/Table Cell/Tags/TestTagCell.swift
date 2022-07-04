//
//  TagsCollectionViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 21/06/22.
//

import UIKit

class TestTagCell: UICollectionViewCell {

    static let identifier = "TestTagCell"
    
    private let title :UILabel = {
        let cellLabel = UILabel()
        cellLabel.numberOfLines = 1
        return cellLabel
    }()
    
    private let deleteButton : UIButton = {
        let deleteButton = UIButton()
        deleteButton.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        return deleteButton
    }()
    

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        contentView.layer.cornerRadius = 8
        contentView.addSubview(title)
        contentView.addSubview(deleteButton)
//        contentView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
    }
    
    override func layoutSubviews() {

        title.sizeToFit()
        title.frame = CGRect(x:0, y:0, width: title.frame.size.width, height: title.frame.size.height)
        

    }
    
    public func configure(with model: TaskTagsOption){
        title.text = model.tagTitle[0]
    }

    
    
}
