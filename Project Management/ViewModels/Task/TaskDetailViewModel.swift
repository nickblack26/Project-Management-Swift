//
//  TaskDetailViewModel.swift
//  Project Management
//
//  Created by Nick on 12/17/22.
//

import Foundation
import CoreData

class TaskDetailViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var due: Date
    @Published var tags: [TagEntity]?
    @Published var assignees: [UserEntity]?
    @Published var list: ListEntity?
    
    let manager = CoreDataManager.shared
    
    var context: TaskEntity?
    
    init(context: TaskEntity? = nil) {
        self.title = context?.title ?? ""
        self.description = context?.desc ?? ""
        self.due = context?.due ?? Date()
        if(context?.list != nil) {
            self.list = context?.list
        }
        if let tempTags = context?.tags?.allObjects as? [TagEntity] {
            self.tags = tempTags
        }
        if let tempAssignees = context?.assignees?.allObjects as? [UserEntity] {
            self.assignees = tempAssignees
        }
        self.context = context ?? nil
    }
    
    func updateTask() {
        context?.title = title
        context?.desc = description
        context?.due = due
        if(!tags!.isEmpty) {
            context?.tags = NSSet(array: tags!)
        }
        if(!assignees!.isEmpty) {
            context?.assignees = NSSet(array: assignees!)
        }
        manager.saveData()
    }
    
    func removeAssignee(assignee: UserEntity) {
        context?.removeFromAssignees(assignee)
        if let index = self.assignees?.firstIndex(of: assignee) {
            assignees?.remove(at: index)
        }
        manager.saveData()
    }
}
