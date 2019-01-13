//
//  PriorityCase.swift
//  todoapp
//
//  Created by Monica Grigorovici on 1/12/19.
//  Copyright © 2019 MonicaProjects. All rights reserved.
//

import UIKit
import CoreData

@objc(PriorityCase)
class PriorityCase: NSManagedObject {

    private struct CodingKeys {
        static let name = "name"
        static let priority = "priority"
        static let color = "color"
    }
    
    enum Priority: String {
        case high
        case medium
        case low
    }
    
    @NSManaged var name: String
    @NSManaged var priority: String
    
    var selfCase: Priority {
        get {
            return Priority.init(rawValue: self.priority)!
        }
    }
    
    var color: UIColor {
        get {
            switch selfCase {
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
            let context = mainApplication.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PriorityCase")
            request.returnsObjectsAsFaults = false
            request.predicate = NSPredicate(format: "name = %@", "High")
            
            do {
                let results:[PriorityCase] = try context.fetch(request) as! [PriorityCase]
                
                if results.count > 0 {
                    return results.first!
                } else {
                    let entity = NSEntityDescription.entity(forEntityName: "PriorityCase", in: context)
                    
                    mainApplication.saveContext()
                    return PriorityCase.init(name: "High", priority: .high, entity: entity!, insertTo: context)
                }
            } catch {
                fatalError("Failed fetching")
            }
        }
    }

    static var medium: PriorityCase {
        get {
            let context = mainApplication.persistentContainer.viewContext

            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PriorityCase")
            request.returnsObjectsAsFaults = false
            request.predicate = NSPredicate(format: "name = %@", "Medium")
            
            do {
                let results:[PriorityCase] = try context.fetch(request) as! [PriorityCase]
                
                if results.count > 0 {
                    return results.first!
                } else {
                    let entity = NSEntityDescription.entity(forEntityName: "PriorityCase", in: context)
                    
                    mainApplication.saveContext()
                    return PriorityCase.init(name: "Medium", priority: .medium, entity: entity!, insertTo: context)
                }
            } catch {
                fatalError("Failed fetching")
            }
        }
    }

    static var low: PriorityCase {
        get {
            let context = mainApplication.persistentContainer.viewContext

            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PriorityCase")
            request.returnsObjectsAsFaults = false
            request.predicate = NSPredicate(format: "name = %@", "Low")
            
            do {
                let results:[PriorityCase] = try context.fetch(request) as! [PriorityCase]
                
                if results.count > 0 {
                    return results.first!
                } else {
                    let entity = NSEntityDescription.entity(forEntityName: "PriorityCase", in: context)
                    
                    mainApplication.saveContext()
                    return PriorityCase.init(name: "Low", priority: .low, entity: entity!, insertTo: context)
                }
            } catch {
                fatalError("Failed fetching")
            }
        }
    }
    
    convenience init(name: String, priority: Priority, entity: NSEntityDescription, insertTo context: NSManagedObjectContext?) {
        self.init(entity: entity, insertInto: context)
        
        self.name = name
        self.priority = priority.rawValue
    }
    
    static func one(priority: String) -> PriorityCase {
        if priority == Priority.low.rawValue {
            return .low
        } else if priority == Priority.medium.rawValue {
            return .medium
        } else {
            return .high
        }
    }
    
}
