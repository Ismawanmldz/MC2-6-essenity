//
//  TaskDetailsTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 20/06/22.
//

import UIKit

class TaskDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "TaskDetailsViewCell"
    
    var cellTitle : String?
    
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
    
    private let label : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconImageView)
        contentView.addSubview(iconContainer)
        contentView.addSubview(label)
        contentView.addSubview(cellLabel)
        contentView.clipsToBounds = true
        accessoryType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x:15, y:6, width: size, height: size)
        
        let imagesize : CGFloat = size/1.5
        iconImageView.frame = CGRect(x:0, y:0, width: imagesize, height: imagesize)
        iconImageView.center = iconContainer.center
        
        label.frame = CGRect(x: 20 + iconContainer.frame.size.width,
                             y: 0,
                             width: contentView.frame.size.width - 15 - iconContainer.frame.size.width,
                             height: contentView.frame.size.height
        )
        
        cellLabel.sizeToFit()
        cellLabel.frame = CGRect(x: contentView.frame.size.width - cellLabel.frame.size.width - 20,
                                      y:  (contentView.frame.size.height - cellLabel.frame.size.height)/2,
                                      width: cellLabel.frame.size.width,
                                      height: cellLabel.frame.size.height)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
    }
    
    public func configure(with model: TaskOption, priority : String){
        label.text = model.title
        iconImageView.image = model.icon
        cellLabel.text = priority
    }
    
    public func configure(with model: TaskOption, task : Task){
        iconImageView.image = model.icon
        label.text = model.title
        cellLabel.text = task.priorities?.title
    }
    
        
}
