//
//  TasksTableViewController.swift
//  todoapp
//
//  Created by Monica Grigorovici on 11/3/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController {

    var project: Project!
    var tasks: Array<Task> {
        get {
            return project.tasks
        }
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

        return self.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskOverviewCollectionViewCell.reuseIdentifier,
                                                 for: indexPath) as! TaskOverviewCollectionViewCell
        
        cell.setup(task: self.tasks[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.project.removeTaskAt(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let share = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            self.performSegue(withIdentifier: Segues.EditTaskSegue, sender: self.project.tasks[indexPath.row])
        }
        
        share.backgroundColor = UIColor.init(rgb: 0x004C4C)
        
        return [delete, share]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CreateTaskTableViewController, let task = sender as? Task else {
            return
        }
        
        destination.task = task
    }
    
}
