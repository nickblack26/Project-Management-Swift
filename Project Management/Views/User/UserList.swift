//
//  UserList.swift
//  Project Management
//
//  Created by Nick on 12/14/22.
//

import SwiftUI

struct UserList: View {
    @StateObject private var vm = CoreDataViewModel()
    
    let task: TaskEntity
    
    var assignees: [UserEntity]?
    @State private var openSet = Set<UserEntity>()
    
    init(task: TaskEntity) {
        self.task = task
        self.assignees = task.assignees?.allObjects as? [UserEntity] ?? []
    }
    
    private func addAssignee(user: UserEntity) -> Void {
        vm.addAssignee(taskContext: self.task, assignee: user)
    }
    
    var body: some View {
        List {
            if(!assignees!.isEmpty) {
                ForEach(assignees!) { user in
                    HStack {
                        Text(user.name!)
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            vm.removeAssignee(taskContext: task, assignee: user)
                        } label: {
                            Label("Remove", systemImage: "trash")
                        }
                    }
                }
            }
            
            Section(header: Text("People")) {
                ForEach(vm.users, id: \.self) { user in
                    if(!task.assignees!.contains(user)) {
                        Button {
                            vm.addAssignee(taskContext: task, assignee: user)
                        } label: {
                            Text(user.name!)
                        }
                    }
                }
            }.headerProminence(.increased)
        }
        .navigationTitle("Assignees")
    }
}

struct UserList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UserList(task: CoreDataViewModel().tasks[0])
        }
    }
}
