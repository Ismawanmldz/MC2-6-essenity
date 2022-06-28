//
//  AddTagsTagsCollectionViewCell.swift
//  MC2-Group6
//
//  Created by Jonathan Andryana on 26/06/22.
//

import UIKit
import CoreData

class AddTagsTagsCollectionViewCell: UICollectionViewCell {

    
    let taskRepository = TaskRepository.shared
    
    var delegate : AddTagsCollectionViewDelegate?
    
        static let identifier = "AddTagsTagsCollectionViewCell"
        
        var thisTag : String?
    
        @IBOutlet var tagLabel: UILabel!

    @IBOutlet weak var xIcon: UIButton!
    
    @IBAction func deleteTag(_ sender: Any) {
        do {
            
            let request = Tags.fetchRequest() as NSFetchRequest<Tags>
            
            let pred = NSPredicate(format: "tagTitle == %@", self.thisTag!)
            request.predicate = pred
            
            let tags = try taskRepository.context.fetch(request)
            
            for tag in tags {
                taskRepository.context.delete(tag)
            }
           try taskRepository.context.save()
            delegate?.reloadPageCV(tagTitle: self.thisTag!)
        }
        catch {
            
        }
        
    }
    
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
            thisTag = type
        }
            
        
        
    }

