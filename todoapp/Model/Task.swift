//
//  Task.swift
//  todoapp
//
//  Created by Monica Grigorovici on 11/5/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit
import Foundation

class Task: NSObject, NSCoding {
    
    struct CodingKeys {
        static let details = "details"
        static let project = "project"
        static let priority = "priorityCase"
        static let date = "date"
    }
    
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
    
    required convenience init?(coder aDecoder: NSCoder) {
        let details = aDecoder.decodeObject(forKey: CodingKeys.details) as! String
        let project = aDecoder.decodeObject(forKey: CodingKeys.project) as! Project
        let priority = aDecoder.decodeObject(forKey: CodingKeys.priority) as! String
        let priorityCase = PriorityCase.one(priority: priority)

        let date = aDecoder.decodeObject(forKey: CodingKeys.date) as! Date
        
        self.init(details: details, project: project, priority: priorityCase, date: date)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.details, forKey: CodingKeys.details)
        aCoder.encode(self.project, forKey: CodingKeys.project)
        aCoder.encode(self.priority.priority, forKey: CodingKeys.priority)
        aCoder.encode(self.date, forKey: CodingKeys.date)
    }
    
}
