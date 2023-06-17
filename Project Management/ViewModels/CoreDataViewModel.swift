//
//  CoreDataViewModel.swift
//  Project Management
//
//  Created by Nick on 12/8/22.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    let manager = CoreDataManager.shared
    
    @Published var users: [UserEntity] = []
    @Published var tasks: [TaskEntity] = []
    @Published var tags: [TagEntity] = []
    
    init() {
        fetchTasks()
        fetchUsers()
        fetchTags()
        
        if(tasks.isEmpty) {
//            addTask(title: "First Task",
//                    due: Date(),
//                    description: "This is a description of the first task created.",
//                    assignees: users
//            )
//            addTask(title: "Second Task", due: Date(), description: "This is a description of the second task created.")
//            addTask(title: "Third Task", due: Date(), description: "This is a description of the third task created.")
        }
        
        if(users.isEmpty) {
            addUser(name: "Nick Black", email: "nicholas.black98@icloud.com")
            addUser(name: "Nick Black", email: "nicholas.black98@icloud.com")
            addUser(name: "Patrick Long", email: "patrick@deepspacerobots.com")
            addUser(name: "Aaron Janke", email: "aaron@deepspacerobots.com")
            addUser(name: "Daniel Lujan", email: "daniel@deepspacerobots.com")
            addUser(name: "Andrew Hale", email: "andrew@deepspacerobots.com")
            addUser(name: "Justin Branham", email: "justin@deepspacerobots.com")
        }
        
        if(tags.isEmpty) {
            addTag(title: "Filters")
            addTag(title: "V2")
            addTag(title: "Nation")
            addTag(title: "Team")
        }
    }
    
    // Fetch Functions
    
    func fetchTags() {
        let tagRequest = NSFetchRequest<TagEntity>(entityName: "TagEntity")
        do {
            tags = try manager.context.fetch(tagRequest)
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
    
    func fetchUsers() {
        let usersRequest = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        do {
            users = try manager.context.fetch(usersRequest)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    // Update Functions
    
    func updateTask(taskContext: TaskEntity, title: String = "", due: Date? = nil, description: String = "", assignees: [UserEntity] = [], tags: [TagEntity] = [], subTasks: [String] = []) {
//        taskContext.title = title
//        taskContext.due = due
        if(!tags.isEmpty) {
            let tagSet = NSSet(array: tags)
            taskContext.tags = tagSet
        }
        saveData()
    }
    
    func addAssignee(taskContext: TaskEntity, assignee: UserEntity) {
        taskContext.addToAssignees(assignee)
        saveData()
    }
    
    func removeAssignee(taskContext: TaskEntity, assignee: UserEntity) {
        taskContext.removeFromAssignees(assignee)
        saveData()
    }
    
    func updateUser(user: UserEntity) {
        saveData()
        fetchUsers()
    }
    
    // Create Functions
    
    func addTag(title: String) {
        let newTag = TagEntity(context: manager.context)
        newTag.title = title
        saveData()
        fetchTags()
    }
    
    func addUser(name: String, email: String?) {
        let newUser = UserEntity(context: manager.context)
        newUser.id = UUID()
        newUser.name = name
        newUser.email = email
        newUser.online = false
        saveData()
        fetchUsers()
    }
    
    func addTask(title: String, due: Date? = nil, description: String = "", list: ListEntity? = nil, assignees: [UserEntity] = [], tags: [TagEntity] = []) -> TaskEntity {
        let newTask = TaskEntity(context: manager.context)
        newTask.title = title
        newTask.due = due
        newTask.desc = description
        newTask.complete = false
        newTask.list = list
        
        if(!tags.isEmpty) {
            let tagSet = NSSet(array: tags)
            newTask.tags = tagSet
        }
        
        if(!assignees.isEmpty) {
            let assigneesSet = NSSet(array: assignees)
            newTask.assignees = assigneesSet
        }
        
        saveData()
        fetchTasks()
        return newTask
    }
    
    // Delete Functions
    
    func deleteTag(tag: TagEntity) {
        manager.context.delete(tag)
        saveData()
        fetchTags()
    }
    
    func deleteUser(user: UserEntity) {
        manager.context.delete(user)
        saveData()
        fetchUsers()
    }
    
    func deleteTask(task: TaskEntity) {
        manager.context.delete(task)
        saveData()
        fetchTasks()
    }
    
    func saveData() {
        do {
            try  manager.context.save()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}
