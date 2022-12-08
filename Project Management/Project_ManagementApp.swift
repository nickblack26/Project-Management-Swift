//
//  Project_ManagementApp.swift
//  Project Management
//
//  Created by Nick on 12/8/22.
//

import SwiftUI

@main
struct Project_ManagementApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
