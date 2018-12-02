//
//  Project.swift
//  todoapp
//
//  Created by Florin Ionita on 11/5/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit

class Project: NSObject, NSCoding {
    
    private struct CodingKeys {
        static let name = "name"
        static let tasks = "tasks"
        static let priority = "priority"
    }
    
    var name: String
    var tasks: Array<Task>
    var priority: PriorityCase
    
    init(name: String, priority: PriorityCase, tasks: Array<Task>) {
        self.name = name
        self.priority = priority
        self.tasks = tasks
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: CodingKeys.name)
        aCoder.encode(self.tasks, forKey: CodingKeys.tasks)
        aCoder.encode(self.priority, forKey: CodingKeys.priority)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: CodingKeys.name) as! String
        let priority = aDecoder.decodeObject(forKey: CodingKeys.priority) as! PriorityCase
        let tasks = aDecoder.decodeObject(forKey: CodingKeys.tasks) as! Array<Task>
        
        self.init(name: name, priority: priority, tasks: tasks)
    }
    
    func addTask(_ task: Task) {
        self.tasks.append(task)
        
        self.persistLocallyProjects()
    }
    
    func removeTaskAt(index: Int) {
        self.tasks.remove(at: index)
        
        self.persistLocallyProjects()
    }
    
    private func persistLocallyProjects() {
        let data = NSKeyedArchiver.archivedData(withRootObject: mainApplication.projects)
        UserDefaults.standard.setValue(data, forKey: UserDefaultsKeys.projects.rawValue)
    }
    
}
