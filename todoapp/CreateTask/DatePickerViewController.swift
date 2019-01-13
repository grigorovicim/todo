//
//  DatePickerViewController.swift
//  todoapp
//
//  Created by Monica Grigorovici on 11/4/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    public var doneActionClousure: ((Date) -> Void)?
    
    var hiddenConstant: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerContainerView.layer.cornerRadius = 6.0
        self.pickerContainerView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        self.pickerContainerView.layer.shadowColor = UIColor.black.cgColor
        self.pickerContainerView.layer.shadowOpacity = 0.2
        self.pickerContainerView.layer.shadowRadius = 6
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.hiddenConstant = self.bottomConstraint.constant
        self.display(true)
    }
    
    private func display(_ display: Bool) {
        let constant = display ? 0.0 : self.hiddenConstant
        let alpha: CGFloat = display ? 0.4 : 0.0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomConstraint.constant = constant
            self.backgroundView.alpha = alpha
            
            self.view.layoutIfNeeded()
        }) { (completed) in
            if !display {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        if let doneActionClousure = self.doneActionClousure {
            doneActionClousure(self.datePicker.date)
        }
        
        self.display(false)
    }
    
}

extension Date {
    func formatted() -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let dateString = dateFormatter.string(from: self)
        
        return dateString
    }
    
    static func from(string: String) -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let date = dateFormatter.date(from: string)
        
        return date!
    }
}
