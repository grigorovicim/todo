//
//  OptionSelectionTableViewController.swift
//  todoapp
//
//  Created by Monica Grigorovici on 11/3/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit

class OptionSelectionTableViewController: UITableViewController {

    public var options = [AnyObject]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    public var selectionClousure: ((AnyObject) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoReusableTableViewCell.reuseIdentifier, for: indexPath) as! TodoReusableTableViewCell
        
        if let item = self.options[indexPath.row] as? Project {
            cell.setup(leftImageName: "", title: item.name, info: "", rightImageName: "")
        } else if let item = self.options[indexPath.row] as? PriorityCase  {
            cell.setup(leftImageName: "", title: item.name, info: "", rightImageName: "")
            cell.leftImageColor = item.color
        }
    
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectionClousure = self.selectionClousure else {
            return
        }
        
        selectionClousure(self.options[indexPath.row])
    }
    
}
