//
//  TaskDetailsTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 20/06/22.
//

import UIKit

class TextFieldTaskDetailsTableViewCell: UITableViewCell {
    
    let taskRepository = TaskRepository.shared
    
    private var cellHeight : Int = 40
    private var noTag : Int = 0
    
    var delegate : TextFieldTaskDetailsTableViewCellDelegate?
    
    static let identifier = "TextFieldTaskDetailsTableViewCell"

    let cellTextField : UITextField = {
        let cellTextField = UITextField()
        let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: cellTextField.frame.height))
        cellTextField.leftView = paddingView
        cellTextField.leftViewMode = UITextField.ViewMode.always
        
        return cellTextField
    }()
    
    private let cellTextView : UITextView = {
        let cellTextView = UITextView()
        let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        cellTextView.textContainerInset = UIEdgeInsets(top: 12, left: 5, bottom: 0, right: 5)
        
        cellTextView.font = UIFont(name: "Arial", size: 17)
        return cellTextView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellTextField)
        contentView.addSubview(cellTextView)
        contentView.clipsToBounds = true
        cellTextField.delegate = self
        accessoryType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size
        cellTextField
            .frame = CGRect(x:0, y:0, width: size.width, height: size.height)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellTextField.text = nil
    }
    
    public func configure(with model: TaskTextFieldOption){
        cellTextField.placeholder = model.placeholder
        self.noTag = model.noTag!
    }
    
    public func configure(with model: TaskTextFieldOption, title : String){
        cellTextField.placeholder = model.placeholder
        self.noTag = model.noTag!
        self.cellTextField.text = title
    }
    

    
}

extension TextFieldTaskDetailsTableViewCell : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if self.noTag == 200 {
            print("this text works")
            
            
            

            let newTag = Tags(context: taskRepository.context)
            newTag.tagTitle = textField.text
                
            
            do {
                try taskRepository.context.save()
                } catch  {
                
                }
            
            delegate?.reloadTags(word: textField.text ?? "")
            textField.text = ""
            textField.resignFirstResponder()
   
            return false
        }
        return true
    }
    
}
