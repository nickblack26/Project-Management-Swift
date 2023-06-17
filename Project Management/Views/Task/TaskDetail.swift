import SwiftUI

extension Binding {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

struct TaskDetail: View {
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
    
    @Environment(\.dismiss) private var dismiss
    
    var list: ListEntity?
    
    init(task: TaskEntity? = nil) {
        self.vm = TaskDetailViewModel(context: task)
        self._taskStartDate = State<Date>(initialValue: task?.due != nil ?  Calendar.current.date(byAdding: .day, value: -1, to: (task?.due!)!)! : Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
        self._showDate = State<Bool>(initialValue: task?.due != nil ? true : false)
        self._showAssignee = State<Bool>(initialValue: task?.assignees != nil && (task?.assignees!.count)! > 0 ? true : false)
        self.list = task?.list
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $vm.title)
            TextField("Enter a description", text: $vm.description, axis: .vertical)
            Section {
                Toggle(isOn: $showStartDate) {
                    HStack {
                        LabelIcon(backgroundColor: .red, icon: "calendar")
                        VStack(alignment: .leading) {
                            Text("Start Date")
                                .font(.subheadline)
                            if(showStartDate) {
                                Button {
                                    showStartDate.toggle()
                                } label: {
                                    Text(taskStartDate, style: .date)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }.onChange(of: showStartDate) { change in
                    if(change) {
                        showStartDatePicker = true
                    }
                }
                
                if(showStartDate && showStartDatePicker) {
                    DatePicker("Due Date", selection: $taskStartDate, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                }
                
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
                                    Text(vm.due, style: .date)
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
                    DatePicker("Due Date", selection: $vm.due, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                }
            }
            
            Section {
                NavigationLink {
                    if(vm.context != nil) {
                        TagList(task: vm.context!)
                    }
                } label: {
                    HStack {
                        LabelIcon(backgroundColor: .gray, icon: "number")
                        Text("Tags")
                            .font(.subheadline)
                        Spacer()
                        if(vm.context != nil && vm.tags!.count > 0) {
                            Text("\(vm.tags!.count) selected")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            
            Section {
                Toggle(isOn: $showAssignee) {
                    HStack {
                        LabelIcon(backgroundColor: .blue, icon: "person")
                        VStack(alignment: .leading) {
                            Text("Assign Task")
                                .font(.subheadline)
                        }
                    }
                }
                if(vm.context != nil && !vm.assignees!.isEmpty && showAssignee) {
                    ForEach(vm.assignees!) { assignee in
                        UserListItem(user: assignee)
                            .swipeActions {
                                Button(role: .destructive) {
//                                    vm.removeAssignee(taskContext: vm., assignee: assignee)
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                    }
                }
                if(showAssignee) {
                    Button {
                        openContextSheet.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                                .font(.caption)
                                .fontWeight(.semibold)
                            Text("Add Assignees")
                            Spacer()
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $openContextSheet) {
            TaskAssigneeList(task: vm.context!)
                .presentationDetents([.medium, .large])
        }
        .toolbar {
            ToolbarItem {
                Menu {
                    Button {
                        
                    } label: {
                        Label("Watchers", systemImage: "eye.circle")
                    }
                    Button(role: .destructive) {
                        
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
            ToolbarItem{
                Button {
                    vm.updateTask()
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

struct Task_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TaskDetail(task: CoreDataViewModel().tasks[0])
        }
    }
}
