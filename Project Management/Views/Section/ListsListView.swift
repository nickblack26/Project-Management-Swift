//
//  SectionListView.swift
//  Project Management
//
//  Created by Nick on 12/21/22.
//

import SwiftUI

struct ListsListView: View {
    @StateObject var vm = ListsListViewModel()
    
    @State private var showNewList: Bool = false
    
//    init(section: SectionEntity) {
//        self.vm = SectionListViewModel(section: section)
//    }
    
    var body: some View {
        List {
            ForEach(vm.lists) { list in
                Text(list.name ?? "")
            }
            .onDelete(perform: vm.removeRows)
            
//            if list.favorite {
//                Section(header: Text("Favorites")) {
//                    NavigationLink(value: list) {
//                        Label(list.name!, systemImage: "list.bullet.indent")
//                    }
//                }
//            } else {
//                NavigationLink(value: list) {
//                    Label(list.name!, systemImage: "list.bullet.indent")
//                }
//                .swipeActions {
//                    Button(role: .destructive) {
//                        vm.removeList(list: list)
//                    } label: {
//                        Label("Remove", systemImage: "trash")
//                    }
//                }
//            }
                
        }
        
//        .navigationTitle(vm.sectionContext.name ?? "Lists")
//        .toolbar {
//            Button {
//                showNewList.toggle()
//            } label: {
//                Image(systemName: "plus")
//            }
//
//        }
    }
}

struct SectionListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListsListView()
        }
    }
}
