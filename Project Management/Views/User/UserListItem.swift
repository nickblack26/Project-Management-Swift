//
//  UserListItem.swift
//  Project Management
//
//  Created by Nick on 12/16/22.
//

import SwiftUI

struct UserListItem: View {
    let user: UserEntity
    
    var body: some View {
        NavigationLink(value: user) {
            HStack {
                ProfileImage(user: user)
                Text(user.name!)
                    .font(.subheadline)
            }
        }
    }
}

struct UserListItem_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List(CoreDataViewModel().users) { user in
                UserListItem(user: user)
            }
        }
    }
}
