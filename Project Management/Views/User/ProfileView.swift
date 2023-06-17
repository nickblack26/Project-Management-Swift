//
//  ProfileView.swift
//  Project Management
//
//  Created by Nick on 12/8/22.
//

import SwiftUI

struct ProfileView: View {
    let user: UserEntity
    @StateObject var vm = CoreDataViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var email: String = ""
    
    init(user: UserEntity) {
        self.user = user
        self._name = State<String>(initialValue: user.name ?? "")
        self._email = State<String>(initialValue: user.email ?? "")
    }
    
    var body: some View {
        Form {
            Section(header: Text("General Info")) {
                TextField(user.name ?? "Full Name", text: $name)
                TextField(user.email ?? "Email", text: $email)
            }
            if let tasks = user.tasks?.allObjects as? [TaskEntity] {
                Section(header: Text("Tasks")) {
                    List(tasks) { task in
                        NavigationLink(value: task) {
                            Text(task.title!)
                        }
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: CoreDataViewModel().users[0])
    }
}
