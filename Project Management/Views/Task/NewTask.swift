//
//  NewTask.swift
//  Project Management
//
//  Created by Nick on 12/8/22.
//

import SwiftUI

struct NewTask: View {
    @StateObject private var vm = CoreDataViewModel()
    @Binding var selectedList: ListEntity?
    
    @State private var taskName: String = ""
    @State private var showDate: Bool = false
    @State private var taskDue: Date = Date()
    @State private var showTime: Bool = false
    
    @State private var showAssignee: Bool = false
    
    @State private var taskDetails: String = ""
    @State private var selectedStatus: String = "Product Backlog"
    @State private var showTag: Bool = false
    @State private var selectedTags = Set<UUID>()
    
    @State private var subTasks: [String] = []
    @State private var selectedUsers: [UserEntity] = []
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $taskName)
                
                Section {
                    Toggle(isOn: $showDate) {
                        HStack {
                            Image(systemName: "calendar")
                                .padding(6)
                                .background(.red)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                            VStack(alignment: .leading) {
                                Text("Due Date")
                                    .font(.subheadline)
                                if(showDate) {
                                    Text(taskDue, style: .date)
                                        .font(.caption)
                                    
                                }
                            }
                        }
                    }
                    
                    if(showDate) {
                        DatePicker("Due Date", selection: $taskDue, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                    }
                    
                    Toggle(isOn: $showTime) {
                        HStack {
                            Image(systemName: "clock")
                                .padding(6)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                            VStack(alignment: .leading) {
                                Text("Add Time")
                                    .font(.subheadline)
                                if(showTime) {
                                    Text(taskDue, style: .time)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    
                    if(showTime) {
                        DatePicker("Due Date", selection: $taskDue, displayedComponents: [.hourAndMinute])
//                            .datePickerStyle(.wheel)
                    }
                }
                
                Section {
                    Picker("Status", selection: $selectedStatus) {
                       
                    }
                    
                    Toggle(isOn: $showTag) {
                        HStack {
                            Image(systemName: "tag")
                                .padding(6)
                                .background(.red)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                            VStack(alignment: .leading) {
                                Text("Tag")
                                    .font(.subheadline)
                            }
                        }
                        
                    }
                    
                   
                }
                
                Section {
                    Toggle(isOn: $showAssignee) {
                        HStack {
                            Image(systemName: "person")
                                .padding(6)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                            VStack(alignment: .leading) {
                                Text("Assign Task")
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                    if(!selectedUsers.isEmpty) {
                        List(selectedUsers) { user in
                            Text(user.name!)
                        }
                    }
                    
                    if(showAssignee) {
                        Picker("Assign Reminder", selection: $selectedUsers) {
                            ForEach(vm.users, id: \.self) { user in
                                Text(user.name ?? "")
                                    .tag(user)
                                
                            }
                        }
                        
//                        .pickerStyle(.navigationLink)
                    }
                }
                
                Section(header: Text("Description")) {
                    TextField("Enter a description", text: $taskDetails, axis: .vertical)
                }
                
                Section(header: Text("Subtasks")) {
                    ForEach(self.$subTasks.indices, id: \.self) { i in
                        TextField("Subtask name", text: $subTasks[i])
                    }
                    Button {
                        self.subTasks.append("")
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add subtask")
                        }
                    }
                    
                }
            }
            .navigationTitle("Details")
//            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
//                        vm.addTask(title: taskName, list: selectedList!)
                        dismiss()
//                        vm.addTask(title: taskName, due: taskDue, description: taskDetails)
                    } label: {
                        Text("Save")
                    }
                }
                ToolbarItem {
//                    EditButton()
                }
            }
        }
    }
}

//struct NewTask_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTask()
//    }
//}
