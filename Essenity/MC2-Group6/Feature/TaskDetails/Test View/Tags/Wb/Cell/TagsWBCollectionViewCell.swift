//
//  TagsWBCollectionViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 22/06/22.
//

import UIKit

class TagsWBCollectionViewCell: UICollectionViewCell {

    static let identifier = "tagsWB"
    
    @IBOutlet weak var tagsWBTitle: UILabel!
    @IBOutlet weak var tagsWbButton: UIButton!
    
    var test : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tagsWBTitle.text = "Test"
        self.layer.cornerRadius = 8
        self.backgroundColor = .systemBlue
    }
    

    func configure() {
        self.tagsWBTitle.text = "Test"
        self.layer.cornerRadius = 8
        self.backgroundColor = .systemBlue
    }
    
    var type: String? {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        self.tagsWBTitle.text = type
    }

    
}
