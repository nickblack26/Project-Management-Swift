//
//  TaskList.swift
//  Project Management
//
//  Created by Nick on 12/8/22.
//

import SwiftUI

struct TaskList: View {
    @ObservedObject private var vm: TaskListViewModel
    @State private var showNewTask: Bool = false
    @State private var editList: Bool = false
    
    init(list: ListEntity? = nil) {
        self.vm = TaskListViewModel(list: list ?? nil)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.tasks) {task in
                    NavigationLink(value: task) {
                        Text(task.title ?? "")
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle(vm.listContext?.name ?? "List")
            .navigationDestination(for: TaskEntity.self) { task in
                TaskDetail(task: task)
            }
            .toolbar {
                ToolbarItem {
                    Menu {
                        Button {
                            editList.toggle()
                        } label: {
                            Text("Edit List")
                        }
                        Button(role: .destructive) {
                            
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
                ToolbarItem {
                    Button {
                        //                                vm.createTask()
                        showNewTask.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            
        }
        .sheet(isPresented: $showNewTask) {
            TaskDetail()
        }
        .sheet(isPresented: $editList) {
            ListDetailView(list: vm.listContext)
        }
    }
    private func delete(at offsets: IndexSet) {
        // delete the objects here
        for offset in offsets {
            let item = vm.tasks[offset]
            vm.deleteTask(task: item)
        }
        vm.tasks.remove(atOffsets: offsets)
    }
}

//struct TaskList_Previews: PreviewProvider {
//    static var previews: some View {
//        if let lists = ContentViewModel().sections[0].lists as? [ListEntity] {
//            TaskList(list: lists[0])
//        }
//    }
//}
