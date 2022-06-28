//
//  TaskTest.swift
//  MC2-Group6
//
//  Created by Elvina Jacia on 27/06/22.
//


import UIKit

class TaskTestController: UIViewController {

//    @IBOutlet weak var TaskCell: UICollectionView!
//    @IBOutlet weak var TaskTableCell: UITableView!
//
//    @IBOutlet weak var BackGroundViewWhite: UIView!
    
    @IBOutlet weak var TaskCell: UICollectionView!
    @IBOutlet weak var TaskTableCell: UITableView!
//    @IBOutlet weak var BackgroundViewWhite: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}

