//
//  TaskAssigneeListViewModel.swift
//  Project Management
//
//  Created by Nick on 12/17/22.
//

import Foundation

class TaskAssigneeListViewModel: ObservableObject {

    @Published var assignees: [UserEntity]?
    
    let manager = CoreDataManager.shared
    var context: TaskEntity
    
    init(context: TaskEntity) {
        self.context = context
        if let assignees = context.assignees?.allObjects as? [UserEntity] {
            self.assignees = assignees
        }
    }
    
    func addAssignees (assignees: Set<UserEntity>) {
        // add assignees to task
        for assignee in assignees {
            context.addToAssignees(assignee)
        }
        manager.saveData()
    }
}
