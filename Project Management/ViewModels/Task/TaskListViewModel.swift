//
//  TaskEntityListViewModel.swift
//  Project Management
//
//  Created by Nick on 12/17/22.
//

import Foundation
import CoreData

class TaskListViewModel: ObservableObject {
    @Published var tasks: [TaskEntity] = []
    @Published var listContext: ListEntity?
    let manager = CoreDataManager.shared
    
    init(list: ListEntity? = nil) {
        self.listContext = list
        if let tasks = list?.tasks?.allObjects as? [TaskEntity] {
            self.tasks = tasks
        }
    }
    
    /* CREATE */
    func createTask() {
        let newTask = TaskEntity(context: manager.context)
        newTask.title = "New Task"
        manager.saveData()
    }
    
    /* READ */
    func refetchTasks() {
        let tasksRequest = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        let sortByDueDate = NSSortDescriptor(key: "due", ascending: false)
        tasksRequest.predicate = NSPredicate(format: "list = %@", self.listContext!)
        
        //        let sortByStartDate = NSSortDescriptor(key: "start", ascending: false)
        //        tasksRequest.sortDescriptors = [sortByDueDate, sortByStartDate]
        
        tasksRequest.sortDescriptors = [sortByDueDate]
        
        do {
            tasks = try manager.context.fetch(tasksRequest)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    /* DELETE */
    func deleteTask(task: TaskEntity) {
        manager.context.delete(task)
        manager.saveData()
        refetchTasks()
    }
    
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
