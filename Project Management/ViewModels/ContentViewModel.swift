//
//  ContentViewModel.swift
//  Project Management
//
//  Created by Nick on 12/19/22.
//

import Foundation
import CoreData

class ContentViewModel: ObservableObject {
    
    @Published var sections: [SectionEntity] = []
    @Published var defaultSections: [SectionEntity] = []
    @Published var favoriteSections: [SectionEntity] = []
    @Published var tasks: [TaskEntity] = []
    @Published var selectedSection: SectionEntity?
    @Published var selectedList: ListEntity?
    
    let manager = CoreDataManager.shared
    
    init() {
        fetchSections()
        fetchTasks()
        
        if(sections.isEmpty) {
//            createSection(title: "Everything")
//            createSection(title: "Global Advance")
//            createSection(title: "NextLevelFan")
//            createSection(title: "Countryside Bible Church")
//            self.selectedSection = sections[0]
        } else {
            self.selectedSection = defaultSections[0]
            if let lists = selectedSection?.lists?.allObjects as? [ListEntity] {
                if(!lists.isEmpty) {
                    self.selectedList = lists[0]
                }
            }
        }
    }
    
    func fetchSections() {
        let sectionRequest = NSFetchRequest<SectionEntity>(entityName: "SectionEntity")
        sectionRequest.predicate = NSPredicate(format: "name != %@ AND favorite = %@", "Everything", NSNumber(value: false))
        let defaultSectionsRequest = NSFetchRequest<SectionEntity>(entityName: "SectionEntity")
        defaultSectionsRequest.predicate = NSPredicate(format: "name == %@", "Everything")
        let favoriteSectionsRequest = NSFetchRequest<SectionEntity>(entityName: "SectionEntity")
        favoriteSectionsRequest.predicate = NSPredicate(format: "favorite = %@", NSNumber(value: true))

        do {
            sections = try manager.context.fetch(sectionRequest)
            defaultSections = try manager.context.fetch(defaultSectionsRequest)
            favoriteSections = try manager.context.fetch(favoriteSectionsRequest)
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
        
    func createSection(title: String) {
        let newSection = SectionEntity(context: manager.context)
        newSection.name = title
        manager.saveData()
        createList(title: "List", section: newSection)
        fetchSections()
    }
    
    func createList(title: String, section: SectionEntity?) {
        let newList = ListEntity(context: manager.context)
        newList.name = title
        if(section != nil) {
            newList.section = section
        }
        manager.saveData()
        fetchSections()
    }
    
    func createTask() {
        let newTask = TaskEntity(context: manager.context)
        newTask.title = "New Task"
        newTask.list = selectedList!
        manager.saveData()
    }
    
    func updateSection(sectionContext: SectionEntity, title: String) {
        sectionContext.name = title
    }
    
    func updateList(listEntity: ListEntity, taskEntity: TaskEntity) {
        print("Updating task")
        listEntity.addToTasks(taskEntity)
        manager.saveData()
    }
    
    
    func deleteList(list: ListEntity) {
        manager.context.delete(list)
        manager.saveData()
        fetchSections()
    }
    
    func deleteSection(section: SectionEntity) {
        manager.context.delete(section)
        manager.saveData()
        fetchSections()
    }
    
    func toggleFavorite(section: SectionEntity? = nil, list: ListEntity? = nil) {
        if(section != nil) {
            section!.favorite.toggle()
        }
        if(list != nil) {
            list!.favorite.toggle()
        }
        manager.saveData()
        fetchSections()
    }
}
