//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Simon Ng on 10/8/2022.
//

import SwiftUI

@main
struct ToDoListApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
