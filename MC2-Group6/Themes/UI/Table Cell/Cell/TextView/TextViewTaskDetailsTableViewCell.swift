//
//  TextViewTaskDetailsTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 22/06/22.
//

import UIKit

class TextViewTaskDetailsTableViewCell: UITableViewCell {
    
    private var cellHeight : Int = 40
    private var customFunc : Any = ()
    
    static let identifier = "TextViewTaskDetailsTableViewCell"

    let cellTextView : UITextView = {
        let cellTextView = UITextView()
        let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        cellTextView.textContainerInset = UIEdgeInsets(top: 12, left: 5, bottom: 0, right: 5)

        cellTextView.font = UIFont(name: "Arial", size: 17)
        return cellTextView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellTextView)
        contentView.clipsToBounds = true
        accessoryType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size
        cellTextView
            .frame = CGRect(x:0, y:0, width: size.width, height: size.height)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellTextView.text = nil
    }
    
    public func configure(with model: TaskTextFieldOption){
        cellTextView.text = ""
        customFunc = model.handler
    
    
    }
    
    public func configure(with model: TaskTextFieldOption, taskDescription : String){
        cellTextView.text = taskDescription
        customFunc = model.handler
    }
    
    public func configure(with model: TaskTextFieldOption, task : Task){
        cellTextView.text = task.desc
        customFunc = model.handler
        
    }
    
}
