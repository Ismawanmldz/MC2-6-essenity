//
//  DeleteTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 22/06/22.
//

import UIKit

class DeleteTableViewCell: UITableViewCell {

        static let identifier = "DeleteTableViewCell"
    
    private let allButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
        private let allContainer: UIView = {
            let view = UIView()
            view.clipsToBounds = true
            view.layer.masksToBounds = true
            return view
        }()
    
        private let cellLabel :UILabel = {
            let cellLabel = UILabel()
            cellLabel.textColor = .systemGray
            return cellLabel
        }()
        
        private let iconContainer: UIView = {
            let view = UIView()
            view.clipsToBounds = true
            view.layer.masksToBounds = true
            return view
        }()
        
        private let iconImageView : UIImageView = {
            let imageView = UIImageView()
            imageView.tintColor = .black
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(iconImageView)
            contentView.addSubview(cellLabel)
            contentView.addSubview(allButton)
            contentView.clipsToBounds = true
            accessoryType = .none
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            contentView.backgroundColor = UIColor.softPink
            
            iconImageView.sizeToFit()
            iconImageView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: iconImageView.frame.size.width,
                                     height: iconImageView.frame.size.height)
            
            cellLabel.sizeToFit()
            cellLabel.frame = CGRect(x: 0,
                                     y: 0,
                                     width: cellLabel.frame.size.width,
                                     height: cellLabel.frame.size.height)
            cellLabel.center = CGPoint(x: ((self.frame.size.width  / 2) - (iconImageView.frame.size.width)/2)-2.5,
                                           y: self.frame.size.height / 2)
            
            iconImageView.center = CGPoint(x: ((self.frame.size.width  / 2) + (cellLabel.frame.size.width)/2) + 2.5,
                                           y: self.frame.size.height / 2)
            cellLabel.textColor = .systemRed
            iconImageView.tintColor =  .systemRed

            
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            iconImageView.image = nil
            cellLabel.text = nil
        }
        
        public func configure(with model: TaskButtonOption){
            cellLabel.text = model.title
            iconImageView.image = model.icon
        }
        
        
            

}
