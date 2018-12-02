//
//  Task.swift
//  todoapp
//
//  Created by Florin Ionita on 11/5/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit

class Task: NSObject {
    var details: String
    var project: Project
    var priority: PriorityCase
    var date: Date
    
    init(details: String, project: Project, priority: PriorityCase, date: Date) {
        self.details = details
        self.project = project
        self.priority = priority
        self.date = date
        
        super.init()
    }
    
}
