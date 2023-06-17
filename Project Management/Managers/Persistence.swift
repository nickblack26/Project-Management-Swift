//
//  Persistence.swift
//  Project Management
//
//  Created by Nick on 12/8/22.
//

import CoreData
import CloudKit

struct PersistenceController {
	// A singleton for our entire app to use
	static let shared = PersistenceController()
	
	// Storage for CloudKit and Core Data
//	let container: NSPersistentCloudKitContainer
	let container: NSPersistentContainer
	
	
	// A test configuration for SwiftUI previews
	static var preview: PersistenceController = {
		let controller = PersistenceController(inMemory: true)
		
		let sectionNames = ["Everything", "Global Advance", "NextLevelFan", "Business Development"]
		
		for i in 0..<3 {
			
			let newSection = SectionEntity(context: controller.container.viewContext)
			newSection.name = sectionNames[i]

			let newList = ListEntity(context: controller.container.viewContext)
			newList.name = "General"

			newSection.addToLists(newList)

			let newTask = TaskEntity(context: controller.container.viewContext)
			newTask.title = "First Task In Last"
			newTask.due = Date()
		}
		
		return controller
	}()	
	
	init(inMemory: Bool = false) {
//		container = NSPersistentCloudKitContainer(name: "Project_Management")
		container = NSPersistentContainer(name: "Project_Management")
		
		if inMemory {
			container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
		}
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
//		container.viewContext.automaticallyMergesChangesFromParent = true
	}
	
	func save() {
		let context = container.viewContext
		
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				// Show some error here
			}
		}
	}
}
