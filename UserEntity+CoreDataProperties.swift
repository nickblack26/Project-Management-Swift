//
//  UserEntity+CoreDataProperties.swift
//  Project Management
//
//  Created by Nick on 12/13/22.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var online: Bool
    @NSManaged public var tasks: NSSet?

    public var wrappedName: String {
        name ?? ""
    }
}

// MARK: Generated accessors for tasks
extension UserEntity {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: TaskEntity)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: TaskEntity)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension UserEntity : Identifiable {

}
