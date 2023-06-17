//
//  CoreDataManager.swift
//  Project Management
//
//  Created by Nick on 12/8/22.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentCloudKitContainer
    let context: NSManagedObjectContext
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Project_Management")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        context = container.viewContext
    }
    
    func saveData() {
		let context = container.viewContext
		
		if context.hasChanges {
			do {
				try context.save()
			} catch let error {
				print("Error saving. \(error)")
			}
		}
    }
}
