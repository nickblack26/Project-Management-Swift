//
//  SectionTabView.swift
//  Project Management
//
//  Created by Nick on 1/10/23.
//

import SwiftUI

struct SectionTabView: View {
    @State private var isHovering: Bool = false
    
    var title: String
    var isActive: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .padding(.horizontal)
//                .overlay {
//                    if isActive {
//                        Divider()
//                            .padding(.top)
//                            .padding(.top)
//                    }
//                }
        }
        .opacity(isHovering || isActive ? 1.0 : 0.5)
        .foregroundColor(isActive ? .green : .primary)
        .onHover { hover in
            isHovering = hover
        }
    }
}

struct SectionTabView_Previews: PreviewProvider {
    static var previews: some View {
        SectionTabView(title: "Overview", isActive: false)
    }
}
