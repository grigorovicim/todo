//
//  RequestsManager.swift
//  todoapp
//
//  Created by Monica Grigorovici on 1/12/19.
//  Copyright © 2019 MonicaProjects. All rights reserved.
//

import UIKit
import Alamofire

class RequestsManager: NSObject {
    
    private static let baseURL = "http://localhost:2999"
    private static let addProjectUrl = "\(baseURL)/add-project"
    private static let getProjectsUrl = "\(baseURL)/all-projects"
    private static let updatePorjectUrl = "\(baseURL)/update-project"

    static func addProject(_ project: Project) {
        let projectDict = self.mapProjectToDictionary(project)
        let params = ["project" : projectDict]
        
        Alamofire.request(addProjectUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success:
                    break
                case .failure:
                    break
                }
        }
    }
    
    static func fetchProjects(completion: @escaping ([Project]) -> Void) {
        Alamofire.request(getProjectsUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    if let arrayOfProjects = json as? Array<[String: Any]> {
                        var projects = Array<Project>.init()
                        
                        for projectDictionary in arrayOfProjects {
                            let project = self.mapDictionaryToProject(projectDictionary)
                            projects.append(project)
                        }
                        
                        completion(projects)
                    } else {
                        completion([])
                    }
                    break
                case .failure:
                    completion([])
                    break
                }
        }
    }
    
    static func updateProject(_ project: Project) {
        let projectDict = self.mapProjectToDictionary(project)
        let params = ["project" : projectDict]
        
        Alamofire.request(updatePorjectUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    break
                case .failure:
                    break
                }
        }
    }
    
    static func mapProjectToDictionary(_ project: Project) -> [String : Any] {
        var projectDictionary = [String : Any]()
        projectDictionary[Project.CodingKeys.name] = project.name
        projectDictionary[Project.CodingKeys.priority] = project.priority.priority
        
        if let id = project.id {
            projectDictionary[Project.CodingKeys.id] = id
        }
        
        var tasks = Array<Dictionary<String, Any>>()
        
        for task in project.tasks {
            var taskDictionary = Dictionary<String, Any>()
            taskDictionary[Task.CodingKeys.details] = task.details
            taskDictionary[Task.CodingKeys.priority] = task.priority.priority
            taskDictionary[Task.CodingKeys.date] = task.date.formatted()
            
            tasks.append(taskDictionary)
        }
        
        projectDictionary[Project.CodingKeys.tasks] = tasks

        return projectDictionary
    }
    
    static func mapDictionaryToProject(_ dictionary: [String : Any]) -> Project {
        let id = dictionary[Project.CodingKeys.id] as! String
        let name = dictionary[Project.CodingKeys.name] as! String
        let priorityCase = dictionary[Project.CodingKeys.priority] as! String
        let tasksDictionaries = dictionary[Project.CodingKeys.tasks] as! Array<[String : Any]>
        
        let project = Project.init(name: name, priority: PriorityCase.one(priority: priorityCase), tasks: Array<Task>.init())
        project.id = id
        
        for taskDictionary in tasksDictionaries {
            let details = taskDictionary[Task.CodingKeys.details] as! String
            let priority = taskDictionary[Task.CodingKeys.priority] as! String
            let date = taskDictionary[Task.CodingKeys.date] as! String
            
            let task = Task.init(details: details, project: project, priority: PriorityCase.one(priority: priority), date: Date.from(string: date))
            
            project.tasks.append(task)
        }
        
        return project
    }
}
