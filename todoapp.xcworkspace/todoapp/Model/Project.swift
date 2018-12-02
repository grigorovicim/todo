//
//  Project.swift
//  todoapp
//
//  Created by Florin Ionita on 11/5/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit

class Project: NSObject {
    var name: String
    var tasks: Array<Task>
    var priority: PriorityCase
    
    init(name: String, priority: PriorityCase, tasks: [Task]) {
        self.name = name
        self.priority = priority
        self.tasks = tasks
        
        super.init()

    }
}
