//
//  ProfileImage.swift
//  Project Management
//
//  Created by Nick on 12/16/22.
//

import SwiftUI
import Foundation

struct ProfileImage: View {
    let user: UserEntity
    
    private func splitName(name: String) -> String {
        let fullNameArr = name.components(separatedBy: " ")
        let firstName = fullNameArr[0]
        let lastName = fullNameArr[1]
        if let firstCharacter = firstName.first {
            if let secondCharacter = lastName.first {
                return "\(firstCharacter)\(secondCharacter)".uppercased()
            }
            return "\(firstCharacter)"
        }
        return ""
    }
    
    var body: some View {
        Text(splitName(name: user.name!))
            .font(.caption2)
            .fontWeight(.medium)
            .frame(width: 25, height: 25)
            .background(.gray)
            .foregroundColor(.white)
            .cornerRadius(50)
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(user: CoreDataViewModel().users[0])
    }
}
