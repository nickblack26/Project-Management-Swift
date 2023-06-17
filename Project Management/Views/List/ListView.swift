//
//  ListView.swift
//  Project Management
//
//  Created by Nick on 12/20/22.
//

import SwiftUI

struct ListView: View {
    
    @Binding var selectedList: ListEntity
    @State private var selectedTask: TaskEntity?
    @State private var showNewTask: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if let tasks = selectedList.tasks?.allObjects as? [TaskEntity] {
                    List(tasks, id: \.self, selection: $selectedTask) { task in
                        NavigationLink(task.title ?? "", value: task)
                    }
                }
            }
            .navigationDestination(for: TaskEntity.self, destination: { task in
                TaskDetail(task: task)
            })
            .navigationTitle(selectedList.name ?? "List Name")
            .toolbar {
                ToolbarItem {
                    Button {
                        showNewTask.toggle()
                    } label: {
                        Label("Add Task", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showNewTask) {
//                NewTask(selectedList: $selectedList)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        if let lists = ContentViewModel().sections[0].lists?.allObjects as? [ListEntity] {
            ListView(selectedList: .constant(lists[0]))
        }
    }
}
