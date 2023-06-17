//
//  NewList.swift
//  Project Management
//
//  Created by Nick on 12/21/22.
//

import SwiftUI

struct ListDetailView: View {
    @ObservedObject var vm: ListDetailViewModel
    
    //    @Binding var selectedSection: SectionEntity?
    @State private var title: String = ""
    @State private var selectedTasks = Set<TaskEntity>()
    @State private var showDate: Bool = false
    @State private var showDatePicker: Bool = false
    @Environment(\.dismiss) var dismiss
    
    init(list: ListEntity? = nil) {
        self.vm = ListDetailViewModel(list: list ?? nil)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Section Title", text: $vm.title, axis: .vertical)
                
                Toggle(isOn: $showDate) {
                    HStack {
                        LabelIcon(backgroundColor: .red, icon: "calendar")
                        VStack(alignment: .leading) {
                            Text("Due Date")
                                .font(.subheadline)
                            if(showDate) {
                                Button {
                                    showDatePicker.toggle()
                                } label: {
                                    Text(vm.date, style: .date)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }.onChange(of: showDate) { change in
                    if(change) {
                        showDatePicker = true
                    }
                }
                
                if(showDate && showDatePicker) {
                    DatePicker("Due Date", selection: $vm.date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                }
                
                Section {
                    TextField("Description", text: $vm.description, axis: .vertical)
                }
            }
            .navigationTitle(vm.section.name ?? "Section Name")
            .toolbar {
                Button {
                    if vm.listContext != nil {
                        vm.updateList()
                    } else {
                        //                        vm.createList()
                    }
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

struct NewList_Previews: PreviewProvider {
    static var previews: some View {
        if let lists = ContentViewModel().sections[0].lists?.allObjects as? [ListEntity] {
            ListDetailView(list: lists[0])
        }
    }
}
