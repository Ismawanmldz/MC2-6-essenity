//
//  PickerTaskDetailsTableViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 25/06/22.
//

import UIKit

class PickerTaskDetailsTableViewCell: UITableViewCell {

    static let identifier = "PickerTaskDetailsTableViewCell"
        
    var delegate : PickerTaskDetailsTableViewCellDelegate?
    
    private var selChoice1 : Int?
    private var selChoice2 : Int?
    private var pickerOption1 : [Int]?
    private var pickerOption2 : [String]?
//    private let pickerDummy = ["Test", "heloo"]
    private var thisValue : String = "None                             "
    private var noTag : Int?
    
    private let doneButton : UIToolbar = {
        let doneButton = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneButton.barStyle = .default
        return doneButton
    }()
    
    private let pickerField : UITextField = {
        let picker = UITextField()
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: picker, action: #selector(doneButtonAction))
//
//        let items = [flexSpace, done]
//        doneToolbar.items = items
//        doneToolbar.sizeToFit()
//
//        picker.inputAccessoryView = doneToolbar
//        picker.isUserInteractionEnabled = false
        picker.isHighlighted = false
        picker.tintColor = .clear
        picker.textColor = .systemGray
        picker.addDoneButtonOnKeyboard()
        picker.textAlignment = .right
        return picker
    }()
    
    private let pickerView : UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
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
    
    @objc func doneButtonAction() {
        
        self.resignFirstResponder()
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(iconImageView)
        contentView.addSubview(iconContainer)
        contentView.addSubview(label)
        contentView.addSubview(pickerField)
        pickerField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
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
 
        pickerField.sizeToFit()
        pickerField.text = thisValue
        pickerField.frame = CGRect(x: contentView.frame.size.width - pickerField.frame.size.width - 20,
                                      y:  (contentView.frame.size.height - pickerField.frame.size.height)/2,
                                      width: pickerField.frame.size.width,
                                      height: pickerField.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
    }
    
    public func configure(with model: TaskPickerOption, timeValue : String){
        label.text = model.title
        iconImageView.image = model.icon
        self.pickerOption1 = model.option1
        self.pickerOption2 = model.option2
        self.thisValue = timeValue
        self.noTag = model.noTag
//        myPicker.selectRow(row, inComponent: 0, animated: true)
//        self.pickerView.selectRow(row : 0, inComponent: 0, animated: true)
//        if(model.title == "Reminder"){
//            delegate?.setDate()
//        } else if model.title == " {
//            delegate.
//        }
    }
    
    
}

extension PickerTaskDetailsTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return pickerOption1!.count
        }
        else{
            return pickerOption2!.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(pickerOption1![row])
        } else {
            return pickerOption2![row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        let selectedChoice1 = pickerView.selectedRow(inComponent: 0)
        let selectedChoice2 = pickerView.selectedRow(inComponent: 1)
        
        print("picker updated")
        let choice1 = pickerOption1![selectedChoice1]
        let choice2 = pickerOption2![selectedChoice2]
        thisValue = "\(choice1) \(choice2)"
        pickerField.text = "\(choice1) \(choice2)"
        
        if selectedChoice2 == 0 {
            thisValue = "None"
            pickerField.text = "None"
        }
        
        
        if(self.noTag == 51){
            delegate?.setDate(no: selectedChoice1+1, type: selectedChoice2, text: pickerField.text!)
        }
        else if(self.noTag == 52){
            delegate?.setMoveTo(no: selectedChoice1+1, type: selectedChoice2, text: pickerField.text!)
        }
    }
}

extension UITextField {

    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }

}
