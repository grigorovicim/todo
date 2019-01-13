//
//  TaskOverviewCollectionViewCell.swift
//  todoapp
//
//  Created by Monica Grigorovici on 11/5/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit

class TaskOverviewCollectionViewCell: UITableViewCell {
    static let reuseIdentifier = "TaskOverviewCollectionViewCellIdentifier"
    
    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var priorityColor: UIColor = .clear {
        didSet {
            self.priorityView.backgroundColor = self.priorityColor
        }
    }
    
    var task: Task? {
        didSet {
            self.priorityColor = task?.priority.color ?? .clear
            self.textView.text = task?.details
            self.dateLabel.text = task?.date.formatted()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.priorityView.layer.cornerRadius = self.priorityView.frame.width / 2
    }
    
    public func setup(task: Task) {
        self.task = task
    }
}
