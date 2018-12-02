//
//  PriorityCase.swift
//  todoapp
//
//  Created by Florin Ionita on 11/5/18.
//  Copyright © 2018 MonicaProjects. All rights reserved.
//

import UIKit

class PriorityCase {
    
    enum Priority {
        case high
        case medium
        case low
    }
    
    var name: String
    var priority: Priority
    var color: UIColor {
        get {
            switch priority {
            case .low:
                return .yellow
            case .medium:
                return .orange
            case .high:
                return .red
            }
        }
    }

    static var high: PriorityCase {
        get {
            return PriorityCase.init(name: "High", priority: .high)
        }
    }
    
    static var medium: PriorityCase {
        get {
            return PriorityCase.init(name: "Medium", priority: .medium)
        }
    }
    
    static var low: PriorityCase {
        get {
            return PriorityCase.init(name: "Low", priority: .low)
        }
    }

    init(name: String, priority: Priority) {
        self.name = name
        self.priority = priority
    }
    
}
