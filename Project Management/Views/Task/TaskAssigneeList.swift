//
//  TaskAssigneeList.swift
//  Project Management
//
//  Created by Nick on 12/17/22.
//

import SwiftUI

struct TaskAssigneeList: View {
    @ObservedObject var vm: TaskAssigneeListViewModel
    @StateObject private var userVM = CoreDataViewModel()
    
    @State private var selectedUsers = Set<UserEntity>()
    @State private var isEditing = true
    
    @Environment(\.dismiss) private var dismiss
    
    init(task: TaskEntity) {
        self.vm = TaskAssigneeListViewModel(context: task)
    }
    
    var body: some View {
        NavigationStack {
            List(userVM.users, id: \.self, selection: $selectedUsers) { user in
                if(!vm.assignees!.contains(user)) {
                    Text(user.name!)
                }
            }
//            .environment(\.editMode, .constant(isEditing ? EditMode.active : EditMode.inactive))
            .navigationTitle("People")
            .toolbar {
                Button {
                    if(isEditing && !selectedUsers.isEmpty) {
                        vm.addAssignees(assignees: selectedUsers)
                    }
                    dismiss()
                } label: {
                    Text(isEditing ? "Done" : "Edit")
                }
            }
        }
    }
}

struct TaskAssigneeList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TaskAssigneeList(task: TaskListViewModel().tasks[0])
        }
    }
}
