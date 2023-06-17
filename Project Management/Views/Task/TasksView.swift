//
//  TaskView.swift
//  Project Management
//
//  Created by Nick on 12/19/22.
//

import SwiftUI
import CoreData

struct TasksView: View {
    
    
    @FetchRequest(entity: TaskEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TaskEntity.due, ascending: false)])
    
//    let tasks: [TaskEntity]
    var tasks: FetchedResults<TaskEntity>
    
    
    
    var body: some View {
        LazyVStack(spacing: 30) {
            if(tasks.isEmpty) {
                
            } else {
                ForEach(tasks, id: \.self) { task in
                    NavigationLink(value: task) {
                        HStack(alignment: .top, spacing: 15) {
                            VStack(alignment: .center) {
                                Circle()
                                    .fill(.primary)
                                    .frame(width: 15, height: 15)
                                    .background(
                                        Circle()
                                            .stroke(.black, lineWidth: 3)
                                            .padding(-3)
                                    )
                                Rectangle()
                                    .fill(.black)
                                    .frame(width: 3)
                            }
                            
                            VStack(alignment: .leading) {
                                HStack(alignment: .top) {
                                    VStack(alignment: .leading) {
                                        Text(task.title ?? "")
                                            .lineLimit(1)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        Text(task.desc ?? "")
                                            .lineLimit(2)
                                            .font(.callout)
                                            .foregroundStyle(.secondary)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    if(task.due != nil) {
                                        Text(task.due!.formatted(.dateTime.day().month()))
                                    }
                                    
                                }
                                
                                    HStack(spacing: -4) {
                                        if let assignees = task.assignees?.allObjects as? [UserEntity] {
                                        ForEach(assignees) { user in
                                            Image("ProfileImage")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 25, height: 25)
                                                .clipShape(Circle())
                                        }
                                    }
                                }
                            }
                            .foregroundColor(.white)
                            .padding()
                            .hLeading()
                            .background(
                                Color("Black")
                                    .cornerRadius(25)
                            )
                        }
                        .hLeading()
                    }
                    
                }
            }
        }
        .padding()
        
    }
}

//struct TaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            TasksView(tasks: HomeViewModel().todaysTasks)
//        }
//    }
//}

extension View {
    func hLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    func hTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    func hCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
}
