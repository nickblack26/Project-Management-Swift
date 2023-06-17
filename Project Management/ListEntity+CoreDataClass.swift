//
//  ListEntity+CoreDataClass.swift
//  Project Management
//
//  Created by Nick on 6/5/23.
//
//

import Foundation
import CoreData


public class ListEntity: NSManagedObject {
	public init(context: NSManagedObjectContext,
				id: UUID = UUID(),
				name: String,
				favorite: Bool,
				order: Int16,
				section: SectionEntity,
				tasks: NSSet?
	) {
		let entity = NSEntityDescription.entity(forEntityName: "ListEntity", in: context)!
		super.init(entity: entity, insertInto: context)
		self.id = id
		self.name = name
		self.favorite = favorite
		self.order = order
		self.section = section
		self.tasks = tasks
	}
	
	@objc
	override private init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
		super.init(entity: entity, insertInto: context)
	}
	
	@available(*, unavailable)
	public init() {
		fatalError("\(#function) not implemented")
	}
	
	@available(*, unavailable)
	public convenience init(context: NSManagedObjectContext) {
		fatalError("\(#function) not implemented")
	}
}
