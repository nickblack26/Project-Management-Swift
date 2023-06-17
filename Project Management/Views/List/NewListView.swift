//
//  NewListView.swift
//  Project Management
//
//  Created by Nick on 5/31/23.
//

import SwiftUI

struct NewListView: View {
    var section: SectionEntity
    @StateObject private var vm: NewListViewModel
    @Environment(\.dismiss) var dismiss
    
    init(section: SectionEntity) {
        self.section = section
        self._vm = StateObject(wrappedValue:NewListViewModel(section: section))
    }
    
    var body: some View {
        Form {
            Section("General") {
                TextField("Name", text: $vm.title)
//                Toggle("Favorite", isOn: $vm.fav)
            }
            
            Section("Associated Content") {
                Picker("Section", selection: $vm.selectedSection) {
                    ForEach(vm.sections) {section in
                        Text(section.name ?? "")
                            .tag(section)
                    }
                }
                Picker("Tasks", selection: $vm.selectedTasks) {
                    ForEach(vm.tasks) { task in
                        Text(task.title ?? "")
                            .tag(task)
                    }
                }
                .pickerStyle(.navigationLink)
            }
        }
        .navigationTitle("New List")
        .toolbar {
            Button {
                vm.createList()
                dismiss()
            } label: {
                Text("Save")
            }

        }
    }
}

struct NewListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
