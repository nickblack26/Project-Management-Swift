//
//  Home.swift
//  Project Management
//
//  Created by Nick on 12/8/22.
//

import SwiftUI

struct Home: View {
    @StateObject private var homeVM = HomeViewModel()
    @Namespace var animation
    @StateObject private var vm = CoreDataViewModel()
    @State private var showNewTask: Bool = false
    @State private var collapsed: Bool = false
    
    var body: some View {
        NavigationStack {
            HomeHeader()
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(homeVM.currentWeek, id: \.self) { day in
                            VStack {
                                Text(homeVM.extractDate(date: day, format: "dd"))
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                Text(homeVM.extractDate(date: day, format: "EEE"))
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                Circle()
                                    .fill(.white)
                                    .frame(width: 8, height: 8)
                                    .opacity(homeVM.isToday(date: day) ? 1 : 0)
                            }
                            .foregroundStyle(homeVM.isToday(date: day) ? .primary : .tertiary)
                            .foregroundColor(homeVM.isToday(date: day) ? .white : .black)
                            .frame(width: 45, height: 90)
                            .background(
                                ZStack {
                                    if homeVM.isToday(date: day) {
                                        Capsule()
                                            .fill(.primary)
                                            .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                    }
                                }
                            )
                            .contentShape(Capsule())
                            .onTapGesture {
                                withAnimation {
                                    homeVM.updateDate(date: day)
                                }
                            }
                        }
                       
                    }
                    .padding(.horizontal)
                }
                TasksView()
            }
            Spacer()
//            List {
//                Section(header: Text("Tasks")) {
//                    ForEach(vm.tasks) { task in
//                        NavigationLink(value: task) {
//                            VStack(alignment: .leading) {
//                                Text(task.title ?? "")
//                                if(task.due != nil) {
//                                    Text(task.due!.formatted(date: .abbreviated, time: .shortened))
//                                        .font(.caption)
//                                        .foregroundColor(.secondary)
//                                }
//                            }
//                        }
//                    }
//                }
//                .headerProminence(.increased)
//
//                Section(header: Text("Tags")) {
//                    ForEach(vm.tags) { tag in
//                        NavigationLink(value: tag) {
//                            HStack {
//                                Text(tag.title ?? "")
//                                Spacer()
//                                if(tag.taskCount > 0) {
//                                    Text("\(tag.taskCount) tasks")
//                                        .font(.callout)
//                                        .foregroundColor(.secondary)
//                                }
//                            }
//                        }
//                    }
//                }
//                .headerProminence(.increased)
//
//                Section(header: Text("Users")) {
//                    ForEach(vm.users) { user in
//                       UserListItem(user: user)
//                    }
//                }
//                .headerProminence(.increased)
//            }
            .navigationDestination(for: TaskEntity.self) { task in
                TaskDetail(task: task)
            }
            .navigationDestination(for: TagEntity.self) { tag in
                TagDetail(tag: tag)
            }
            .navigationDestination(for: UserEntity.self) { user in
                ProfileView(user: user)
            }
//            .toolbar {
//                ToolbarItem {
//                    Menu {
//                        Button {
//                            showNewTask.toggle()
//                        } label: {
//                            Label("New Task", systemImage: "checkmark")
//                        }
//                        Button {
//                            
//                        } label: {
//                            Label("New Project", systemImage: "folder")
//                        }
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
        }
//        .refreshable {
//            vm.fetchTasks()
//        }
//        .navigationTitle("Home")
        .sheet(isPresented: $showNewTask) {
//            NewTask()
        }
    }
//    func delete(at offsets: IndexSet) {
//        for offset in offsets {
//            let task = vm.tasks[offset]
//            vm.deleteTask(task: task)
//        }
//        vm.tasks.remove(atOffsets: offsets)
//    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//extension View {
//    func getSafeArea() -> UIEdgeInsets {
//        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
//            return .zero
//        }
//        guard let safeArea = screen.windows.first?.safeAreaInsets else {
//            return .zero
//        }
//        
//        return safeArea
//    }
//}
