//
//  FilterCollectionViewCell.swift
//  MC2-Group6
//
//  Created by Hana Salsabila on 27/06/22.
//

import UIKit

class TagFilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagButton: UIButton!
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
            return layoutAttributes
    }
    
    var callbackTag : (()->())?
    
    @IBAction func didTag(_ sender: UIButton) {
        callbackTag?()
    }
    
    
    
}

