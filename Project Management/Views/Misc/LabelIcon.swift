//
//  LabelIcon.swift
//  Project Management
//
//  Created by Nick on 12/15/22.
//

import SwiftUI

struct LabelIcon: View {
    
    var backgroundColor: Color
    var icon: String
    
    var body: some View {
        Image(systemName: icon)
            .font(.callout)
            .fontWeight(.medium)
            .frame(width: 25, height: 25)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(5)
    }
}

struct LabelIcon_Previews: PreviewProvider {
    static var previews: some View {
        LabelIcon(backgroundColor: .red, icon: "calendar")
    }
}
