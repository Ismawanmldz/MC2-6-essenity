//
//  TagFilter.swift
//  MC2-Group6
//
//  Created by Hana Salsabila on 27/06/22.
//

import UIKit

class TagFilter {
    
    var chooseFilterTag : String!
    var filterColor : UIColor!
    var isTag = false
    
    public init(chooseFilterTag: String, filterColor: UIColor){
        self.chooseFilterTag = chooseFilterTag
        self.filterColor = filterColor
    }
}
