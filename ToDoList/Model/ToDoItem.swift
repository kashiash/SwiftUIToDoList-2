//
//  ToDoItem.swift
//  SwiftUIToDoList
//
//  Created by Simon Ng on 10/8/2022.
//

import Foundation
import CoreData
import SwiftUI

enum Priority: Int {
    case low = 0
    case normal = 1
    case high = 2
}

public class ToDoItem: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var whenNum: Int32
    @NSManaged public var priorityNum: Int32
    @NSManaged public var isComplete: Bool
}


enum When: Int {
    case later = 0
    case today = 1
    case asap = 2
    case now = 3
    case date = 4
    
    var name: String {
        get { return String(describing: self) }
    }
    
    var description: String {
        get { return String(reflecting: self) }
    }
    
    func imageName() -> String{
        
        switch self {
        case .later: return "calendar.badge.exclamationmark"
        case .today: return "calendar.badge.exclamationmark"
        case .asap: return "clock.badge.exclamationmark"
        case .now: return "alarm.waves.left.and.right"
        case .date: return "clock.badge"
        }
    }
    
    func color() -> Color {
        switch self {
        case .later: return .blue
        case .today: return .green
        case .asap: return .orange
        case .now: return .red
        case .date: return .teal
        }
    }
    
}

extension ToDoItem: Identifiable {
    
    var priority: Priority {
        get {
            return Priority(rawValue: Int(priorityNum)) ?? .normal
        }
        
        set {
            self.priorityNum = Int32(newValue.rawValue)
        }
    }
    
//    var when: When {
//        get {
//            return When(rawValue: Int(whenNum)) ?? .later
//        }
//        
//        set {
//            self.whenNum = Int32(newValue.rawValue)
//        }
//    }
}
