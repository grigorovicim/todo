//
//  CreateTaskTableViewController.swift
//  todoapp
//
//  Created by Florin Ionita on 11/3/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit

class CreateTaskTableViewController: UITableViewController {

    // MARK: - Properties
    
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    private var items = [
        0 : [
            TodoReusableTableViewCellItem.init(title: "", info: ""),
            TodoReusableTableViewCellItem.init(title: "Project", info: "", leftImageName: "file", rightImageName: "right_arrow", options: mainApplication.projects),
        ],
        
        1 : [
            TodoReusableTableViewCellItem.init(title: "Date", info: "", leftImageName: "calendar", rightImageName: "right_arrow", options: nil),
            TodoReusableTableViewCellItem.init(title: "Priority", info: "", leftImageName: "flag", rightImageName: "right_arrow", options: [PriorityCase.low, PriorityCase.medium, PriorityCase.high]),
        ],
    ]
    
    var taskDescription: String = "" {
        didSet {
            self.items[0]![0].title = taskDescription
        }
    }
    
    var project: Project? {
        set {
            guard let project = newValue else {
                return
            }
            
            if let previous = items[0]![1].selection as? Project, previous.name != project.name {
                let matchingProject = mainApplication.projects.first { (currentProject) -> Bool in
                    currentProject.name == project.name
                }
                
                if let task = self.task {
                    matchingProject?.addTask(task)
                    previous.removeTaskAt(index: previous.tasks.firstIndex(of: task)!)
                }
            }
            
            items[0]![1].info = project.name
            items[0]![1].selection = project
        }
        
        get {
            return items[0]![1].selection as? Project
        }
    }
    
    var date: Date? {
        set {
            guard let date = newValue else {
                return
            }
            
            items[1]![0].info = date.formatted()
            items[1]![0].selection = date as AnyObject
        }
        
        get {
            return items[1]![0].selection as? Date
        }
    }
    
    var priority: PriorityCase? {
        set {
            guard let priority = newValue else {
                return
            }
            
            items[1]![1].info = priority.name
            items[1]![1].selection = priority
        }
        
        get {
            return items[1]![1].selection as? PriorityCase
        }
    }
    
    var task: Task? {
        didSet {
            guard let task = task else {
                return
            }
            
            self.taskDescription = task.details
            self.project = task.project
            self.date = task.date
            self.priority = task.priority
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupRightBarButton()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section]!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = (indexPath.section == 0 && indexPath.row == 0) ? TaskDescriptionTableViewCell.reuseIdentifier : TodoReusableTableViewCell.reuseIdentifier
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                 for: indexPath)
        
        let cellItem = self.items[indexPath.section]![indexPath.row]
        
        if let descriptionCell = cell as? TaskDescriptionTableViewCell {
            descriptionCell.task = cellItem.title
            descriptionCell.textUpdateClousure = { (text) in
                self.taskDescription = text
            }
        } else if let reusableCell = cell as? TodoReusableTableViewCell {
            reusableCell.setup(leftImageName: cellItem.leftImageName,
                               title: cellItem.title,
                               info: cellItem.info,
                               rightImageName: cellItem.rightImageName)
        }
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return UITableView.automaticDimension
        }
        
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        view.backgroundColor = UIColor.init(rgb: 0x282828)
        
        return view
    }
    
    // Mark: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.section]![indexPath.row]
        
        let selectionClousure: ((AnyObject) -> Void) = { (selection) in
            self.navigationController?.popToViewController(self, animated: true)
            
            if let selection = selection as? Project {
                item.info = selection.name
                self.project = selection
            } else if let selection = selection as? PriorityCase {
                item.info = selection.name
                self.priority = selection
            }
            
            item.selection = selection
            
            self.tableView.reloadData()
        }
        
        let doneActionClousure: ((Date) -> Void) = { (date) in
            self.date = date
            item.info = date.formatted()
            item.selection = date as AnyObject
            
            self.tableView.reloadData()
        }
        
        let isDatePicker = (indexPath.section == 1 && indexPath.row == 0)
        let segueIdentifier = isDatePicker ? Segues.DatePickerTableViewControllerSegue : Segues.OptionSelectionTableViewControllerSegue
        let object = isDatePicker ? doneActionClousure as AnyObject : (selectionClousure, item) as AnyObject
        
        self.performSegue(withIdentifier: segueIdentifier, sender: object)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OptionSelectionTableViewController  {
            guard let (selectionClousure, item) = sender as? (((AnyObject) -> Void), TodoReusableTableViewCellItem) else {
                return
            }
            
            destination.options = item.options
            destination.selectionClousure = selectionClousure
        } else if let destination = segue.destination as? DatePickerViewController {
            guard let doneActionClousure = sender as? ((Date) -> Void) else {
                return
            }
            
            destination.doneActionClousure = doneActionClousure
        }
    }
    
    // MARK: - Private
    
    private func setupRightBarButton() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "done"), for: .normal)
        button.addTarget(self, action: #selector(CreateTaskTableViewController.doneButtonTapped), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.rightBarButton.customView = button
    }
    
    @objc private func doneButtonTapped() {
        if let task = self.task {
            task.details = self.taskDescription
            task.project = self.project!
            task.priority = self.priority!
            task.date = self.date!
        } else {
            let task = Task.init(details: self.taskDescription, project: self.project!, priority: self.priority!, date: self.date!)
            
            self.project!.addTask(task)
        }

        self.navigationController?.popViewController(animated: true)
    }
    
}
