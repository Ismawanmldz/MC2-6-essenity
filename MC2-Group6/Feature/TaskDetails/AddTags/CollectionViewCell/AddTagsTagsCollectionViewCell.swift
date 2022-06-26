//
//  AddTagsTagsCollectionViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 26/06/22.
//

import UIKit

class AddTagsTagsCollectionViewCell: UICollectionViewCell {

        static let identifier = "AddTagsTagsCollectionViewCell"
        
        @IBOutlet var tagLabel: UILabel!

    @IBOutlet weak var xIcon: UIButton!
    
        var type: String? {
            didSet {
                setupView()
            }
        }
        
        
        func setupView() {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 17, weight: .thin, scale: .small)
                   
            let largeBoldDoc = UIImage(systemName: "x.circle.fill", withConfiguration: largeConfig)

            xIcon.setImage(largeBoldDoc, for: .normal)
            
            xIcon.tintColor = .white
//            xIcon.backgroundColor = .green
            self.layer.cornerRadius = 8
            self.backgroundColor = .systemBlue
            tagLabel.tintColor = .white
            tagLabel.text = type
        }
            
        
        
    }

