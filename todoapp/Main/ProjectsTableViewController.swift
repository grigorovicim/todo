//
//  ProjectsTableViewController.swift
//  todoapp
//
//  Created by Florin Ionita on 11/3/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit

struct Segues {
    static let TasksTableViewControllerSegue = "TasksTableViewControllerSegue"
    static let OptionSelectionTableViewControllerSegue = "OptionSelectionTableViewControllerSegue"
    static let CreateTaskTableViewControllerSegue = "CreateTaskTableViewControllerSegue"
    static let DatePickerTableViewControllerSegue = "DatePickerTableViewControllerSegue"
    static let EditTaskSegue = "EditTaskSegue"
    static let PostAuthenticationSegue = "PostAuthenticationSegue"
}

class ProjectsTableViewController: UITableViewController {
    
    var projectsItems: [ProjectTableViewCellItem] {
        get {
            var items = [ProjectTableViewCellItem]()
            
            for project in mainApplication.projects {
                items.append(ProjectTableViewCellItem.init(project: project))
            }
            
            return items
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projectsItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.reuseIdentifier, for: indexPath) as! ProjectTableViewCell
        let item = self.projectsItems[indexPath.row]
        
        cell.setup(priority: item.priority, title: item.title, numberOfTasks: item.numberOfTasks)

        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = self.projectsItems[indexPath.row].project
        
        self.performSegue(withIdentifier: Segues.TasksTableViewControllerSegue, sender: project)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TasksTableViewController, let project = sender as? Project else {
            return
        }
        
        destination.project = project
    }
    
}
