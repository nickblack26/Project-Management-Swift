//
//  TasksViewController.swift
//  Project Management
//
//  Created by Nick on 12/19/22.
//

import Foundation
import CoreData

class TasksViewController: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var newTasks = [TaskViewModel]()
    
    
    
    private let fetchedResultsController: NSFetchedResultsController<TaskEntity>
    
    @Published var tasks: [TaskEntity] = []
    
    override init() {
        
    }
    
    /* CREATE */
    func createTask() {
        let newTask = TaskEntity(context: manager.context)
        newTask.title = "New Task"
        manager.saveData()
    }
    
    /* READ */
    func fetchTasks() {
        let tasksRequest = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        let sortByDueDate = NSSortDescriptor(key: "due", ascending: false)
        
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
        fetchTasks()
    }
}
