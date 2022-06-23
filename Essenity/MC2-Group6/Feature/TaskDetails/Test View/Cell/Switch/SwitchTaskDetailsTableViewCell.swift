//
//  TaskDetailsTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 20/06/22.
//

import UIKit

class SwitchTaskDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "SwitchTaskDetailsViewCell"
    
    var delegate: SwitchTaskDetailsTableViewCellDelegate?
    private var noTag : Int = 0
    
//    private var isOn : Bool = true
    
    lazy var cellSwitch: UISwitch = {
        let cellSwitch = UISwitch()
        cellSwitch.onTintColor = .systemBlue
        cellSwitch.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
        cellSwitch.tag = self.noTag
        return cellSwitch
    }()
    
    @objc func switchToggled() {
        if cellSwitch.tag == 31 {
            delegate?.priorityTapped(noTag: self.noTag)
        } else if cellSwitch.tag == 32 {
            delegate?.priorityTapped(noTag: self.noTag)
        } else if cellSwitch.tag == 41 {
            print("double")
            delegate?.dueDateTapped()
        }
        
        if cellSwitch.isOn {
//            print(self.noTag)
//            delegate?.dueDateTapped()
            print("on")
        } else {
            print("off")
        }
    }

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
        contentView.addSubview(cellSwitch)
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
        
        cellSwitch.sizeToFit()
        cellSwitch.frame = CGRect(x: contentView.frame.size.width - cellSwitch.frame.size.width - 20,
                                  y:  (contentView.frame.size.height - cellSwitch.frame.size.height)/2,
                                  width: cellSwitch.frame.size.width,
                                  height: cellSwitch.frame.size.height)
        
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        cellSwitch.isOn = false
    }
    
    public func configure(with model: SettingsSwitchOption){
        label.text = model.title
        iconImageView.image = model.icon
        self.noTag = model.noTag
        cellSwitch.tag = self.noTag
        cellSwitch.isOn = model.isOn
    }
    
    public func configure(with model: SettingsSwitchOption, dueDateOn : Bool){
        label.text = model.title
        iconImageView.image = model.icon
        self.noTag = model.noTag
        cellSwitch.tag = self.noTag
        cellSwitch.isOn = dueDateOn
    }
    
}
