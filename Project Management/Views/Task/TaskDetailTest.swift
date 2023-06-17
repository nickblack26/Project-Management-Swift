//
//  TaskDetailTest.swift
//  Project Management
//
//  Created by Nick on 12/17/22.
//

import SwiftUI

struct TaskDetailTest: View {
    @ObservedObject var vm: TaskDetailViewModel
    @State private var showDate: Bool = false
    @State private var showDatePicker: Bool = false
    
    init(task: TaskEntity) {
        self.vm = TaskDetailViewModel(context: task)
        self._showDate = State<Bool>(initialValue: task.due != nil ? true : false)
    }
    var body: some View {
        Form {
            TextField("Title", text: $vm.title)
            TextField("Description", text: $vm.description)
            
            Section {
                Toggle(isOn: $showDate) {
                    HStack {
                        LabelIcon(backgroundColor: .red, icon: "calendar")
                        VStack(alignment: .leading) {
                            Text("Due Date")
                                .font(.subheadline)
                            if(vm.due != nil) {
                                Button {
                                    showDatePicker.toggle()
                                } label: {
                                    Text(vm.due!, style: .date)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }.onChange(of: showDate) { change in
                    if(change) {
                        vm.due = Date()
                        showDatePicker = true
                    }
                }
                
                if(showDate && showDatePicker) {
                    DatePicker("Due Date", selection: $vm.due.toUnwrapped(defaultValue: Date()), displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                }
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    vm.updateTask()
                } label: {
                    Text("Done")
                }
            }
        }
    }
}

struct TaskDetailTest_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailTest(task: CoreDataViewModel().tasks[0])
    }
}
