//
//  ListEntity+CoreDataProperties.swift
//  Project Management
//
//  Created by Nick on 6/5/23.
//
//

import Foundation
import CoreData


extension ListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListEntity> {
        return NSFetchRequest<ListEntity>(entityName: "ListEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
	@NSManaged public var favorite: Bool
    @NSManaged public var order: Int16
    @NSManaged public var section: SectionEntity
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension ListEntity {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: TaskEntity)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: TaskEntity)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension ListEntity : Identifiable {

}
