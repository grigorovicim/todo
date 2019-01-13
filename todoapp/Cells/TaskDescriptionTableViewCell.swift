//
//  TaskDescriptionTableViewCell.swift
//  todoapp
//
//  Created by Monica Grigorovici on 11/3/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit

class TaskDescriptionTableViewCell: UITableViewCell, UITextViewDelegate {
    static let reuseIdentifier = "TaskDescriptionTableViewCellIdentifier"
    
    @IBOutlet weak private var textView: UITextView!
    @IBOutlet weak private var upperSeparatorView: UIView!
    @IBOutlet weak private var lowerSeparatorView: UIView!
    
    var textUpdateClousure: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textView.delegate = self
    }
    
    public var task: String = "" {
        didSet {
            self.textView.text = task
        }
    }
    
    public var hideUpperSeparator = false {
        didSet {
            self.upperSeparatorView.isHidden = self.hideUpperSeparator
        }
    }
    
    public var hideLowerSeparator = false {
        didSet {
            self.lowerSeparatorView.isHidden = self.hideLowerSeparator
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let textUpdateClousure = self.textUpdateClousure else {
            return
        }
        
        textUpdateClousure(textView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
