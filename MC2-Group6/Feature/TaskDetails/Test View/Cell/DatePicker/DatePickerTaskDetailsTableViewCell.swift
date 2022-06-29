//
//  TaskDetailsTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 20/06/22.
//

import UIKit

class DatePickerTaskDetailsTableViewCell: UITableViewCell {
    
    var minimumDate : Date?
    
    static let identifier = "DatePickerTaskDetailsViewCell"
    
    private var dateUpdated : Date?
    var delegate : DatePickerTaskDetailsTableViewCellDelegate?
    
    private let cellDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = UIDatePicker.Mode.date
//        datePicker.minimumDate = Date()
//        datePicker.addTarget(DatePickerTaskDetailsTableViewCell.self, action: #selector(dateChanged), for: .valueChanged)

        datePicker.addTarget(self, action: #selector(handler(sender:)), for: UIControl.Event.valueChanged)
        return datePicker
    }()
    
    @objc func handler(sender: UIDatePicker) {
        dateUpdated = cellDatePicker.date
        delegate?.updateDueDate(date: cellDatePicker.date)
        print("this works")
    }
    
    @objc func dateChanged() {
        dateUpdated = cellDatePicker.date
        delegate?.updateDueDate(date: cellDatePicker.date)
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

        contentView.addSubview(cellDatePicker)

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
        
        cellDatePicker.sizeToFit()
        cellDatePicker.frame = CGRect(x: contentView.frame.size.width - cellDatePicker.frame.size.width - 20,
                                      y:  (contentView.frame.size.height - cellDatePicker.frame.size.height)/2,
                                      width: cellDatePicker.frame.size.width,
                                      height: cellDatePicker.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
    }
    
    public func configure(with model: TaskDatePickerOption){
        label.text = model.title
        iconImageView.image = model.icon
    }
    
    public func configure(with model: TaskDatePickerOption, dateDue : Date){
        label.text = model.title
        iconImageView.image = model.icon
        self.cellDatePicker.date = dateDue
        self.minimumDate = dateDue
        cellDatePicker.reloadInputViews()
        cellDatePicker.minimumDate = self.minimumDate
    }
    
    
    public func configure(with model: TaskDatePickerOption, dateDue : Date, dueDateOn : Bool){
        label.text = model.title
        iconImageView.image = model.icon
        self.cellDatePicker.date = Date()
        self.minimumDate = dateDue
        cellDatePicker.reloadInputViews()
        cellDatePicker.minimumDate = self.minimumDate
    }
    
}
