//
//  NewSectionView.swift
//  Project Management
//
//  Created by Nick on 5/31/23.
//

import SwiftUI

struct NewSectionView: View {
    @StateObject private var vm = NewSectionViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            TextField("Name", text: $vm.name)
        }
        .toolbar {
            ToolbarItem {
                Button("Save") {
                    vm.createList()
                    dismiss()
                }
                .disabled(vm.name.isEmpty)
            }
        }
    }
}

struct NewSectionView_Previews: PreviewProvider {
    static var previews: some View {
        NewSectionView()
    }
}
