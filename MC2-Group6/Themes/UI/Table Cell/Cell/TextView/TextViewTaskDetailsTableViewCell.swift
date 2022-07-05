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
        cellTextView.delegate = self
        
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
        cellTextView.text = "Description Here"
        cellTextView.textColor = UIColor.placeholderText


        cellTextView.selectedTextRange = cellTextView.textRange(from: cellTextView.beginningOfDocument, to: cellTextView.beginningOfDocument)
    
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

extension TextViewTaskDetailsTableViewCell : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            // Combine the textView text and the replacement text to
            // create the updated text string
            let currentText:String = textView.text
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

            // If updated text view will be empty, add the placeholder
            // and set the cursor to the beginning of the text view
            if updatedText.isEmpty {

                textView.text = "Description Here"
                textView.textColor = UIColor.placeholderText

                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }

            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, set
            // the text color to black then set its text to the
            // replacement string
             else if textView.textColor == UIColor.placeholderText && !text.isEmpty {
                textView.textColor = UIColor.black
                textView.text = text
            }

            // For every other case, the text should change with the usual
            // behavior...
            else {
                return true
            }

            // ...otherwise return false since the updates have already
            // been made
            return false
    }
    
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if cellTextView.text != nil {
            if textView.textColor == UIColor.placeholderText {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}
