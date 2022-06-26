//
//  AddTagsViewController.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 26/06/22.
//

import UIKit

class AddTagsViewController: UIViewController {

    
    let identifier = "AddTagsViewController"
    
    
    let arr : [String] = ["+ Add Tags","Assignment","Exam","Assignment","Project"]
    
    private var tags : [String]?
    
    @IBOutlet weak var tagsTableView: UITableView!
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    
    //    private let tableView: UITableView  = {
//        let table = UITableView(frame: .zero, style: .insetGrouped)
//        table.register(TextFieldTaskDetailsTableViewCell.self, forCellReuseIdentifier: TextFieldTaskDetailsTableViewCell.identifier)
//        table.registerCell(type: TagsTableViewCell.self, identifier: TagsTableViewCell.identifier)
//
//        return table
//    }()
//
    override func viewDidLoad() {
        super.viewDidLoad()
//        tagsCollectionView.registerCell(type: TagsTaskDetailsCollectionViewCell.self, identifier: "TagsTaskDetailsCollectionViewCell")
        tagsTableView.register(TextFieldTaskDetailsTableViewCell.self, forCellReuseIdentifier: TextFieldTaskDetailsTableViewCell.identifier)
        tagsTableView.registerCell(type: AddTagsTagsTableViewCell.self, identifier: AddTagsTagsTableViewCell.identifier)
        configure()
        title = "Add Tags"
        tagsTableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tagsTableView.delegate = self
        tagsTableView.dataSource = self
//        tagsCollectionView.delegate = self
//        tagsCollectionView.dataSource = self

//        tableView.frame =
        
    }
    
    var models = [Section]()
    
    func configure() {
        models.append(Section(title: "", options: [
            .textFieldCell(model: TaskTextFieldOption(title: "New Tag" ,handler: {
                
            }, cellHeight: 0, noTag : 200,placeholder: "Write New Tag Here...")),
        ]))
        
        models.append(Section(title: "Tags : ", options: [
            .tagsCell(model: TaskTagsOption(tagTitle: ["String","Apple","Bed","duck"], handler: {
                print("tags Clicked")
            })),
        
        ]))
        
    }
}
    
extension AddTagsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "New Tag"
        }
        return "Tags"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.models[indexPath.section].options[indexPath.row]
    
        switch model.self {
        case .textFieldCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TextFieldTaskDetailsTableViewCell.identifier,
                for: indexPath
            ) as? TextFieldTaskDetailsTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.configure(with: model)
            return cell
        case .tagsCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AddTagsTagsTableViewCell.identifier,
                for: indexPath
            ) as? AddTagsTagsTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .clear
            cell.tintColor = .clear
//            cell.configure(with: model)
            return cell
        default :
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 220
        }
        return 44
    }
        
}

extension AddTagsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagsCollectionView.dequeueReusableCell(
            withReuseIdentifier: "TagsTaskDetailsCollectionViewCell",
            for: indexPath) as! TagsTaskDetailsCollectionViewCell
        
        
        cell.type = arr[indexPath.row]
        cell.backgroundColor = .systemBlue
        
        return cell
    }
    

}

extension AddTagsViewController : TextFieldTaskDetailsTableViewCellDelegate {
    func reloadTags() {
        self.tagsTableView.reloadSections([1], with: .none)
}

}
