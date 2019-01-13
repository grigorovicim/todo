//
//  Project.swift
//  todoapp
//
//  Created by Monica Grigorovici on 11/5/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit

class Project: NSObject, NSCoding {
    
    public struct CodingKeys {
        static let name = "name"
        static let tasks = "tasks"
        static let priority = "priorityCase"
        static let id = "_id"
    }
    
    var name: String
    var tasks: Array<Task>
    var priority: PriorityCase
    var id: String?
    
    init(name: String, priority: PriorityCase, tasks: Array<Task>) {
        self.name = name
        self.priority = priority
        self.tasks = tasks
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: CodingKeys.name)
        aCoder.encode(self.tasks, forKey: CodingKeys.tasks)
        aCoder.encode(self.priority.priority, forKey: CodingKeys.priority)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: CodingKeys.name) as! String
        let priority = aDecoder.decodeObject(forKey: CodingKeys.priority) as! String
        let priorityCase = PriorityCase.one(priority: priority)
        let tasks = aDecoder.decodeObject(forKey: CodingKeys.tasks) as! Array<Task>
        
        self.init(name: name, priority: priorityCase, tasks: tasks)
    }
    
    func addTask(_ task: Task) {
        self.tasks.append(task)
        
        self.persistLocallyProjects()
    }
    
    func removeTaskAt(index: Int) {
        self.tasks.remove(at: index)
        
        self.persistLocallyProjects()
    }
    
    func persistLocallyProjects() {
        if mainApplication.hasInternetConnection {
            if let _ = self.id {
                RequestsManager.updateProject(self)
            } else {
                RequestsManager.addProject(self)
            }
        } else {
            let data = NSKeyedArchiver.archivedData(withRootObject: mainApplication.projects)
            UserDefaults.standard.setValue(data, forKey: UserDefaultsKeys.projects.rawValue)
        }
    }
    
}
