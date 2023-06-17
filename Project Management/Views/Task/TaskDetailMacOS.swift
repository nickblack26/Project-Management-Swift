//
//  TaskDetailMacOS.swift
//  Project Management
//
//  Created by Nick on 12/19/22.
//

import SwiftUI

struct Comment: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    let comment: String
    let date: Date = Date()
    let update: Bool = true
}

struct Status: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    let completed: Bool
    let color: Color
}

struct TaskDetailMacOS: View {
    @ObservedObject var vm: TaskDetailViewModel
    @StateObject private var userVM = CoreDataViewModel()
    
    @State private var showSheet: Bool = false
    @State private var taskStartDate: Date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    @State private var showStartDate: Bool = false
    @State private var showStartDatePicker: Bool = false
    @State private var showDate: Bool = false
    @State private var showDatePicker: Bool = false
    @State private var showAssignee: Bool = false
    @State private var showTag: Bool = false
    @State private var openContextSheet: Bool = false
    
    @State private var selectedStatus: Status?
    
    let statuses = [
        Status(name: "PRODUCT BACKLOAG", completed: false, color: .gray),
        Status(name: "SPRINT BACKLOG", completed: false, color: .purple),
        Status(name: "DOING", completed: false, color: .pink),
        Status(name: "QA REVIEW", completed: false, color: .pink),
        Status(name: "DONE", completed: true, color: .green)
    ]
    
    let comments = [
        Comment(name: "Brian Barker", comment: "Brian Barker created this task"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
        Comment(name: "Brian Barker", comment: "Brian Barker changed status from Product Backlog to Sprint"),
    ]
    
    @Environment(\.dismiss) private var dismiss
    
    init(task: TaskEntity) {
        self.vm = TaskDetailViewModel(context: task)
        self._taskStartDate = State<Date>(initialValue: task.due != nil ?  Calendar.current.date(byAdding: .day, value: -1, to: task.due!)! : Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
        self._showDate = State<Bool>(initialValue: task.due != nil ? true : false)
        self._showAssignee = State<Bool>(initialValue: task.assignees!.count > 0 ? true : false)
        self._selectedStatus = State<Status?>(initialValue: statuses[0])
    }
    
    var body: some View {
        VStack {
            HStack {
                Picker("Status", selection: $selectedStatus) {
                    ForEach(statuses) { status in
                        Text(status.name)
                            .padding()
                            .background {
                                Rectangle()
                                    .fill(status.color)
                            }
                            .tag(status)
                    }
                }
                Button {
                    
                } label: {
                    ZStack {
                        Image(systemName: "checkmark")
                    }
                    
                }
                HStack(spacing: -5) {
                    ForEach(0..<5) { index in
                        Image("ProfileImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 25, height: 25)
                            .clipShape(Circle())
                    }
                }
            }
            .padding()
            Divider()
            
            HStack {
                ScrollView {
                    TextField("Title", text: $vm.title)
                        .font(.title)
                    TextEditor(text: $vm.description)
                    Spacer()
                }
                .padding()
                Divider()
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        ForEach(comments, id: \.self) { comment in
                            HStack {
                                Text("\(comment.comment)")
                                    .font(.caption)
                                    .foregroundStyle(comment.update ? .secondary : .primary)
                                Spacer()
                                Text("\(comment.date.formatted(date: .numeric, time: .omitted)) at \(comment.date.formatted(date: .omitted, time: .shortened))")
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    
    struct TaskDetailMacOS_Previews: PreviewProvider {
        static var previews: some View {
            TaskDetailMacOS(task: CoreDataViewModel().tasks[0])
        }
    }
}
