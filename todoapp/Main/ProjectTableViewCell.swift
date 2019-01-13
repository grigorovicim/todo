//
//  ProjectTableViewCell.swift
//  todoapp
//
//  Created by Monica Grigorovici on 11/3/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit

struct ProjectTableViewCellItem {
    var title: String = ""
    var priority: PriorityCase = .low
    var numberOfTasks: Int = 0
    var project: Project
    
    init(project: Project) {
        self.project = project
        self.title = project.name
        self.priority = project.priority
        self.numberOfTasks = project.tasks.count
    }
}

class ProjectTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ProjectTableViewCellItemIdentifier"
    
    @IBOutlet weak private var dotView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var separatorView: UIView!
    @IBOutlet weak private var numberOfTasksLabel: UILabel!
    
    public var priorityColor: UIColor = .clear {
        didSet {
           self.dotView.backgroundColor = priorityColor
        }
    }
    
    public var hideSeparatorView: Bool = false {
        didSet {
            self.separatorView.isHidden = self.hideSeparatorView
        }
    }
    
    public var title: String = "" {
        didSet {
            self.titleLabel.text = self.title
        }
    }
    
    public var numberOfTasks: Int = 0 {
        didSet {
            self.numberOfTasksLabel.isHidden = (self.numberOfTasks == 0)
            self.numberOfTasksLabel.text = String(self.numberOfTasks)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dotView.layer.cornerRadius = self.dotView.frame.width / 2
    }
    
    public func setup(priority: PriorityCase,
                      title: String,
                      numberOfTasks: Int) {
        
        self.priorityColor = priority.color
        self.title = title
        self.numberOfTasks = numberOfTasks
    }
    
}
