//
//  TaskMainPage.swift
//  MC2-Group6
//
//  Created by Ismawan Maulidza on 6/27/22.
//

import Foundation
import UIKit

class TaskMainPage{

    var title: String!
    var description: String!
    var dueDate: String!
    var tags : [String]!
    var priority : String!
    var status : String!
    var check : String!
    var isFavorite = false
    var isTag = false
//    var isChecked : Bool

    public init(title: String, description: String, dueDate: String, tags: [String], priority: String, status: String, check: String) {
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.tags = tags
        self.priority = priority
        self.status = status
        self.check = check
    }

}
