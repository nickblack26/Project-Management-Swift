//
//  Project_ManagementApp.swift
//  Project Management
//
//  Created by Nick on 12/8/22.
//

import SwiftUI

@main
struct Project_ManagementApp: App {
	@Environment(\.scenePhase) var scenePhase
//	let persistenceController = PersistenceController.shared
	let persistenceController = CoreDataManager.shared
	
	var body: some Scene {
//#if os(iOS)
		WindowGroup {
			ContentView()
				.environment(\.managedObjectContext, persistenceController.container.viewContext)
		}
		.onChange(of: scenePhase) { _ in
			persistenceController.saveData()
		}
//#elseif os(macOS)
//		WindowGroup {
//			ContentView()
//				.environment(\.managedObjectContext, persistenceController.container.viewContext)
//		}
//		.onChange(of: scenePhase) { _ in
//			persistenceController.save()
//		}
//		.windowToolbarStyle(.expanded)
//#endif
	}
}
