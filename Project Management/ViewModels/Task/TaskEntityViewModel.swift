//
//  TaskEntityViewModel.swift
//  Project Management
//
//  Created by Nick on 12/16/22.
//

import Foundation
import CoreData

class TaskEntityViewModel: ObservableObject {
    let manager = CoreDataManager.shared
    
    @Published var tasks: [TaskEntity] = []
    
    init() {
        fetchTasks()
        
        if(tasks.isEmpty) {
//            let newUser1 = addTask(title: "First Task",
//                                   due: Date(),
//                                   description: "This is a description of the first task created."
//            )
//            let newUser2 = addTask(title: "Second Task", due: Date(), description: "This is a description of the second task created.")
//            let newUser3 = addTask(title: "Third Task", due: Date(), description: "This is a description of the third task created.")
        }
    }
    
    /* CREATE */
    private func addTask(title: String, due: Date? = nil, description: String = "", assignees: [UserEntity] = [], tags: [TagEntity] = []) -> TaskEntity {
        let newTask = TaskEntity(context: manager.context)
        newTask.title = title
        newTask.due = due
        newTask.desc = description
        
        if(!tags.isEmpty) {
            let tagSet = NSSet(array: tags)
            newTask.tags = tagSet
        }
        
        if(!assignees.isEmpty) {
            let assigneesSet = NSSet(array: assignees)
            newTask.assignees = assigneesSet
        }
        
        manager.saveData()
        fetchTasks()
        return newTask
    }

    
    /* READ */
    private func fetchTasks() {
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
    
    
    /* UPDATE */
    private func addAssignee(taskContext: TaskEntity, assignee: UserEntity) {
        taskContext.addToAssignees(assignee)
        manager.saveData()
    }
    private func removeAssignee(taskContext: TaskEntity, assignee: UserEntity) {
        taskContext.removeFromAssignees(assignee)
        manager.saveData()
    }
    private func updateTask(taskContext: TaskEntity, title: String = "", due: Date? = nil, description: String = "", assignees: [UserEntity] = [], tags: [TagEntity] = [], subTasks: [String] = []) {
        //        taskContext.title = title
        //        taskContext.due = due
        if(!tags.isEmpty) {
            let tagSet = NSSet(array: tags)
            taskContext.tags = tagSet
        }
        manager.saveData()
    }
    
    
    /* DELETE */
    private func deleteTask(task: TaskEntity) {
        manager.context.delete(task)
        manager.saveData()
        fetchTasks()
    }
}
