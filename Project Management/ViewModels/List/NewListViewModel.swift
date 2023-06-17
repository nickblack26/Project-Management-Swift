//
//  NewListViewModel.swift
//  Project Management
//
//  Created by Nick on 12/21/22.
//

import Foundation
import CoreData

class NewListViewModel: ObservableObject {
    @Published var tasks: [TaskEntity] = []
    @Published var sections: [SectionEntity] = []
    @Published var selectedSection: SectionEntity
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var selectedTasks = Set<TaskEntity>()
    let manager = CoreDataManager.shared
    
    init(section: SectionEntity? = nil) {
        self.selectedSection = section!
        fetchTasks()
        fetchSections()
    }
    
    func createList() {
        let newList = ListEntity(context: manager.context)
        newList.id = UUID()
        newList.name = self.title
        newList.section = self.selectedSection
        newList.tasks = selectedTasks as NSSet

        manager.saveData()
    }
    
    func fetchLists() {
        let listsRequest = NSFetchRequest<ListEntity>(entityName: "ListEntity")
        do {
           let _ = try manager.context.fetch(listsRequest)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func fetchTasks() {
        let tasksRequest = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        do {
            tasks = try manager.context.fetch(tasksRequest)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func fetchSections() {
        let sectionRequest = NSFetchRequest<SectionEntity>(entityName: "SectionEntity")
        do {
            sections = try manager.context.fetch(sectionRequest)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
}
